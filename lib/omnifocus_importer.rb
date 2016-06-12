require "active_record"
require "./app/models/task"
require "csv"

class OmnifocusImporter
  class FileNotFound < StandardError; end

  def initialize(file)
    raise FileNotFound unless File.exist? file
    @file = file
  end

  def import_to_active_record
    CSV::Converters[:blank_to_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end

    body = IO.read @file
    csv = CSV.new(
      body,
      headers: true,
      header_converters: :symbol,
      converters: [:all, :blank_to_nil]
    )

    args = csv.to_a.map { |row| row.to_hash }.
      select { |row| row[:type] == "Action" }.
      map    { |row| row[:flagged] = row[:flagged] == 1 ? true : false; row }.
      map    { |row| row[:type_of_object] = row[:type]                ; row }.
      map    { |row| row.select { |key, _v| Task::ATTRIBUTES.include? key } }

    args.each { |arg| Task.find_or_create_by arg }
  end
end
