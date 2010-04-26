module Dullist
  class Actions < Controller
    map '/' #this must be called in the derived class??
    
    def index
      @title = request[:title]
      @order = request[:order]
      @tasks = @order ? Task.order(@order.to_sym).all : Task.all
    end
    
    def update
      id_collection = request[:pending_table][1..-1] + request[:done_table][1..-1]
      id_collection.each_with_index { |id, i|
        task = Task[:id => id]
        task.priority = i
        task.save
      }
      redirect route('/', :order => 'priority')
      #how do we assume order, or how to reflect the context of the ordered html table back into model?
      #must read sequel's 'order' method
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