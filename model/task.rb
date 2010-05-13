module Dullist
  require 'helper/helper'
  class Task < Sequel::Model(:tasks)
    table_name = :tasks
    if empty?
      create :title => 'Laundry', :md5 => Digest::MD5.hexdigest('Laundry')
      create :title => 'Wash dishes', :md5 => Digest::MD5.hexdigest('Wash dishes')
    end
    #------------ instance parts below -------------
    def status
      done ? 'Done' : 'Pending'
    end
    
    def linkto(action)
        Actions.route(action, md5) #this generate a relative-path URI
    end
    
    def toggle_link
      action = done ? 'open' : 'close'
      Actions.anchor(action, linkto(action)) #this returns real anchor (link) in string(html format)
    end
    
    def delete_link
      Actions.anchor('delete', linkto('delete')) #this returns real anchor (link) in string(html format)
    end
    
    def href_or_title
      Helper.make_href(href, title)
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
