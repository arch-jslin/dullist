module Dullist
  class Task < Sequel::Model
#    set_schema {
#      primary_key :id
#      varchar :title, :unique => true, :empty => false
#      varchar :md5,   :unique => true, :empty => false
#      boolean :done, :default => false
#      integer :priority, :default => 1
#    }

#    create_table unless table_exists?
   
    if empty?
      create :title => 'Laundry', :md5 => Digest::MD5.hexdigest('Laundry')
      create :title => 'Wash dishes', :md5 => Digest::MD5.hexdigest('Wash dishes')
    end
    #------------ instance parts below -------------
    def status
      done ? 'Done' : 'Pending'
    end
    
    def href(action)
        Actions.route(action, md5) #this generate a relative-path URI
    end
    
    def toggle_link
      action = done ? 'open' : 'close'
      Actions.anchor(action, href(action)) #this returns real anchor (link) in string(html format)
    end
    
    def delete_link
      Actions.anchor('delete', href('delete')) #this returns real anchor (link) in string(html format)
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
