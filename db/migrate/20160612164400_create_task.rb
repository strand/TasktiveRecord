class CreateTask < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string   :name
      t.text     :notes

      t.string   :context # context is used for polymorphic associations
      t.string   :project

      t.datetime :completion_date
      t.datetime :due_date
      t.datetime :start_date

      t.string   :duration # Relative time storage?
      t.boolean  :flagged
      t.string   :task_id
      t.string   :type_of_object
    end
  end
end
