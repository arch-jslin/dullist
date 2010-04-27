module Dullist
  require 'sequel'
  require 'sequel/extensions/migration'
  require 'model/create_initial_table_v1'

  Sequel::Model.plugin(:schema)
  db = Sequel.sqlite(__DIR__'../dullist.db')
  CreateInitTableV1.apply(db, :up) unless db.table_exists?('tasks')
end

require 'model/task'