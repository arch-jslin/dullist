module Dullist
  class Task < Sequel::Model(:tasks)
    table_name = :tasks
    if empty?
      create :title => 'Laundry', :md5 => Digest::MD5.hexdigest('Laundry')
      create :title => 'Wash dishes', :md5 => Digest::MD5.hexdigest('Wash dishes')
    end
    
    @@protocol = 'http|https|ftp'
    @@suffix   = 'biz|com|edu|gov|info|mil|name|net|org'+
                 '|aq|au|br|ca|ch|cn|cr|cz|de|dk|eg|es|eu|fi|fr|gr|hk|it|kr|nl|no|se|tw|uk|us'
    @@autolink_regex = Regexp.new(
      '( ('+@@protocol+')://)*'+       #add comments here
      '( (\d{1,3}\.){3,3}\d{1,3}|'+  
        '((-|\w)+\.)+('+@@suffix+')|'+ 
        '((-|\w)+\.)*localhost )'+  
      '(:\d{1,5})?'+                 
      '(/\S+)*', Regexp::EXTENDED)
    
    def Task.parse_link(title)
      title.gsub(@@autolink_regex) {|match| 
        link = match
        link = 'http://' + link if (match[0..3] != 'http' && match[0..2] != 'ftp')
        "<a href='#{link}' target='_blank'>#{match}</a>" 
      }
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
        link = href
        link = 'http://' + link if (href[0..3] != 'http' && href[0..2] != 'ftp')
        "<a href='#{link}' target='_blank'>#{title}</a>"
      end
    end
  end
end
