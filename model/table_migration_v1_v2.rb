module Dullist
  class Migration_V1_V2 < Sequel::Migration
    def Migration_V1_V2.num_of_columns 
      CreateInitTableV2.num_of_columns - CreateInitTableV1.num_of_columns
    end
    def up
      alter_table :tasks do
        add_column :urgent, TrueClass, :default => false
        add_column :time, DateTime
      end
    end
    
    def down
      alter_table :tasks do
        drop_column :urgent
        drop_column :time
      end
    end
  end
end #Dullist