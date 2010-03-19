class Actions < Ramaze::Controller
  map '/'
   
  def close(title)
    change_state(title) { |task| task.done = true }
  end 
  
  def open(title)
    change_state(title) { |task| task.done = false }
  end
  
  def delete(title) 
    change_state(title) { |task| task.destroy }
  end
  
  def create
    if request.post? && title = request[:title]
      title.strip!
      title = h(title)
      Task.create :title => title unless title.empty?
    end
      redirect_referrer
    rescue Sequel::DatabaseError
      redirect_referrer
  end
  
  def change_state(title, &action)
    task = Task[:title => title]
    action.call(task)
    task.save unless task == nil  #not necessarily need this condition.
    redirect_referrer
  end
end