module Dullist
  class Task < Sequel::Model(:tasks)
    table_name = :tasks
    if empty?
      create :title => 'Laundry', :md5 => Digest::MD5.hexdigest('Laundry')
      create :title => 'Wash dishes', :md5 => Digest::MD5.hexdigest('Wash dishes')
    end
    
    def Task.parse_link(title)
      title.gsub(/((http|https|ftp):\/\/\S+.)/) {|match| "<a href='#{match}' target='_blank'>#{match}</a>" }
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
    
    def open!
      self.done = false
      save
    end
    
    def close!
      self.done = true
      save
    end
    
    def make_href
      if href == nil || href.length < 1
        title
      else
        "<a href='#{href}' target='_blank'>#{title}</a>"
      end
    end
  end
end
