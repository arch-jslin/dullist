module Dullist
  class CreateInitTableV1 < Sequel::Migration
    def up
      create_table :tasks do
        primary_key :id
        varchar :title, :unique => true, :empty => false
        varchar :md5,   :unique => true, :empty => false
        boolean :done, :default => false
        integer :priority, :default => 1      
      end
    end
      
    def down
      drop_table :tasks
    end
  end
end