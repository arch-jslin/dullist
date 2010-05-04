module Dullist
  class CreateCategories < Sequel::Migration
    def CreateCategories.num_of_columns 
      5
    end
    def up
      create_table :categories do
        primary_key :id
        varchar :name, :unique => true, :empty => false
        varchar :md5,  :unique => true, :empty => false
        integer :num_of_tasks, :default => 0
        DateTime :time        
      end
    end
      
    def down
      drop_table :categories
    end
  end
end