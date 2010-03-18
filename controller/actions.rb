
class Actions < Ramaze::Controller
  map '/'
   
  def close(title)
    task = Task[:title => title]
    task.done = true
    task.save
    
    redirect_referrer
  end 
end