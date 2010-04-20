module Dullist
  class Actions < Controller
    map '/' #this must be called in the derived class??
    
    def index
      @title = request[:title]
      @tasks = Task.all
    end
    
    def update2
      p request[:pending_table].to_s + request[:done_table].to_s
    end
  
    def close(key)
      task = Task[:md5 => key]
      task.close!
      redirect route('/', :title => task.title)
    end 
  
    def open(key)
      task = Task[:md5 => key]
      task.open!
      redirect route('/', :title => task.title)
    end
  
    def delete(key) 
      Task[:md5 => key].destroy
      redirect route('/')
    end
    
    def create
      if request.post? && title = request[:title]
        title.strip!
        title = h(title)
        key = Digest::MD5.hexdigest(title)
        unless title.empty? or Task[:md5 => key] != nil
            Task.create :title => title, :md5 => key
        end
      end
        redirect route('/', :title => title)
      rescue Sequel::DatabaseError => ex
        #expecting someone would insert tasks with the same name
        #so we catch it here.
        redirect route('/', :title => title)
    end
  end
end