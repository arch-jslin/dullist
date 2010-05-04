module Dullist
  class CreateInitTableV3 < Sequel::Migration
    def CreateInitTableV3.num_of_columns 
      9
    end
    def up
      create_table :tasks do
        primary_key :id
        varchar :title, :unique => true, :empty => false
        varchar :md5,   :unique => true, :empty => false
        boolean :done, :default => false
        integer :priority, :default => 1    
        boolean :urgent, :default => false
        DateTime :time        
        varchar :href
        varchar :category
      end
    end
      
    def down
      drop_table :tasks
    end
  end
end