module Dullist
  class Migration_V2_V3 < Sequel::Migration
    def Migration_V2_V3.num_of_columns 
      CreateInitTableV3.num_of_columns - CreateInitTableV2.num_of_columns
    end
    def up
      alter_table :tasks do
        add_column :href, String
        add_column :category, String
      end
    end
    
    def down
      alter_table :tasks do
        drop_column :href
        drop_column :category
      end
    end
  end
end #Dullist