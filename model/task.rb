module Dullist
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
    #------------ instance parts below -------------
    def encode(str)
      Ramaze::Helper::CGI.url_encode(str)
    end
    
    def status
      done ? 'Done' : 'Pending'
    end
    
    def href(action)
        Actions.route(action, encode(title)) #this generate a relative-path URI
    end
    
    def toggle_link
      action = done ? 'open' : 'close'
      Actions.anchor(action, href(action)) #this returns real anchor (link) in html
    end
    
    def delete_link
      Actions.anchor('delete', href('delete')) #this returns real anchor (link) in html
    end
    
    def open!
      self.done = false
      save
    end
    
    def close!
      self.done = true
      save
    end
  end
end
