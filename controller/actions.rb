module Dullist
  class Actions < Controller
    map '/' #this must be called in the derived class??
    
    def index
      @title = request[:title]
      @tasks = Task.all
    end
    
    def done(title = '')
      @title = title
      @tasks = Task.all
    end
  
    def back_to_main(title = '') #is this really necessary?
      redirect route('/', :title => title)
    end
   
    def close(title)
      title = Ramaze::Helper::CGI.url_decode(title)
      Task[:title => title].close!
      redirect route('/', :title => title)
    end 
  
    def open(title)
      title = Ramaze::Helper::CGI.url_decode(title)
      Task[:title => title].open!
      redirect route('/', :title => title)
    end
  
    def delete(title)
      title = Ramaze::Helper::CGI.url_decode(title)
      Task[:title => title].destroy
      redirect route('/', :title => title)
    end
    
    def create
      if request.post? && title = request[:title]
        title.strip!
        title = h(title)
        Task.create :title => title unless title.empty?
      end
        redirect route('/', :title => title)
      rescue Sequel::DatabaseError => ex
        #expecting someone would insert tasks with the same name
        #so we catch it here.
        redirect route('/', :title => title)
    end
  end
end