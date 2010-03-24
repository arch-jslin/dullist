class Actions < Ramaze::Controller
  map '/'
  layout :default
  
  def Actions.prefix
    ''
  end
  
  def index
    @title = request[:title]
  end
  
  def done(title)
    @title = title
  end
  
  def back_to_main(title = '') #is this really necessary?
    redirect route('/', :title => title)
  end
   
  def close(title)
    change_state(title) { |task| task.done = true }
  end 
  
  def open(title)
    change_state(title) { |task| task.done = false }
  end
  
  def delete(title) 
    change_state(title) { |task| task.destroy }
  end
    
  def change_state(title, &action)
    task = Task[:title => title]
    action.call(task)
    task.save unless task == nil  #not necessarily need this condition.
    redirect_referrer
  end
  
  def create
    if request.post? && title = request[:title]
      title.strip!
      title = h(title)
      Task.create :title => title unless title.empty?
    end
      redirect route('/', :title => title)
    rescue Sequel::DatabaseError  
    #expecting someone would insert tasks with the same name
    #so we catch it here.
      redirect route('/', :title => title)
  end
end