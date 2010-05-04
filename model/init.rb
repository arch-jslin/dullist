module Dullist

  #this file requires inevitable refactoring.

  require 'sequel'
  require 'sequel/extensions/migration'
  require 'model/create_initial_table_v1'
  require 'model/create_initial_table_v2'
  require 'model/create_initial_table_v3'
  require 'model/create_categories_v1'
  require 'model/table_migration_v1_v2'
  require 'model/table_migration_v2_v3'

  Sequel::Model.plugin(:schema)
  db = Sequel.sqlite(__DIR__'../dullist.db')
  
  #create a table describing categories.
  CreateCategories.apply(db, :up) unless db.table_exists?('categories')
  
  if db.table_exists?('tasks')
    p db[:tasks].columns
    case db[:tasks].columns.size
    when CreateInitTableV1.num_of_columns
      Migration_V1_V2.apply(db, :up)
      Migration_V2_V3.apply(db, :up)
    when CreateInitTableV2.num_of_columns 
      Migration_V2_V3.apply(db, :up)
    when CreateInitTableV3.num_of_columns
      p "No upgrade needed" 
    else
      p "your table don't fits in the upgrading process."
    end
  else
    CreateInitTableV3.apply(db, :up) unless db.table_exists?('tasks')
  end
end

require 'model/task'