module Dullist
  class Actions < Controller
    map '/' #this must be called in the derived class??
    
    def index
      @title = request[:title]
      @order = request[:order]
      @tasks = @order ? Task.order(@order.to_sym).all : Task.order(:priority).all 
      #now we start using priority as the main order
    end
    
    def update
      return unless request.post?
      id_collection = request[:pending_table][1..-1] + request[:done_table][1..-1] 
      #p id_collection #debug
      id_collection.each_with_index { |id, i|
        task = Task[:id => id]
        if task.priority != i 
          task.priority = i
          task.save
        end
      }
      redirect route('/', :order => 'priority')
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
          Task.create :title => title, :md5 => key, :time => DateTime.now, :urgent => false
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