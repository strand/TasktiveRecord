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
    csv = CSV.new(body,
                  headers: true,
                  header_converters: :symbol,
                  converters: [:all, :blank_to_nil]
    )
    args = csv.to_a.map { |row| row.to_hash }
    args.map! { |hash| hash.select { |key, _v| Task::Attributes.include? key } }
    args.each do |arg|
      Task.create arg
    end
  end
end
