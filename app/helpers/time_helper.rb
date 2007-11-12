=begin
RailsCollab
-----------

=end

module TimeHelper
  include ActionView::Helpers::ProjectHelper
  
  def task_select_list(task_list)
  	items = []
  	task_list.each do |task_list|
  		items << [html_escape(task_list.name), task_list.id]
  		items += task_list.project_tasks.collect do |task|
  			if task.assigned_to.nil?
  				["--#{html_escape task.text}", task.id+1000]
  			else
  				["--#{html_escape task.assigned_to.name}: #{html_escape task.text}", task.id+1000]
  			end
  		end
  	end
  	
  	items = [["--None--", 0]] + items
  end

end