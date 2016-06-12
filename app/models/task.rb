class Task < ActiveRecord::Base
  ATTRIBUTES = %i(name notes
                  context_tag project_tag
                  completion_date due_date start_date
                  duration flagged task_id type_of_object).freeze
end
