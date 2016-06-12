require 'active_record'

ActiveRecord::Base.establish_connection(
   :adapter => 'sqlite3',
   :host => "localhost",
   :database => 'db/test.sqlite3'
)
