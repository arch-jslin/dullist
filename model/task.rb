class Task < Sequel::Model
  set_schema {
    primary_key :id
    varchar :title, :unique => true, :empty => false
    boolean :done, :default => false
  }

  create_table unless table_exists?

  if empty?
    create :title => 'Laundry'
    create :title => 'Wash dishes'
  end
end