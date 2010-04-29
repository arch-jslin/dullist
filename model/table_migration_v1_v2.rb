module Dullist
  class Migration_V1_V2 < Sequel::Migration
    def up
      alter_table :tasks do
        add_column :urgent, boolean, :default => false
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