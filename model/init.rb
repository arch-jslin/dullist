module Dullist
  require 'sequel'
  require 'sequel/extensions/migration'
  require 'model/create_initial_table_v1'
  require 'model/create_initial_table_v2'
  require 'model/table_migration_v1_v2'

  Sequel::Model.plugin(:schema)
  db = Sequel.sqlite(__DIR__'../dullist.db')
  #CreateInitTableV1.apply(db, :up) unless db.table_exists?('tasks')
  if db.table_exists?('tasks')
    p db[:tasks].columns
    if db[:tasks].columns.size == CreateInitTableV1.num_of_columns
      Migration_V1_V2.apply(db, :up)
    end
  else
    CreateInitTableV2.apply(db, :up) unless db.table_exists?('tasks')
  end
end

require 'model/task'