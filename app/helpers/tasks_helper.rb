module TasksHelper
	def list_id
		if @task.deadline === Date.today && @task.completed == false
			return "#todays_tasks"
		elsif @task.deadline != Date.today && @task.completed == false
			return "#future_tasks"
		elsif @task.completed == true
			return "#completed_tasks"
		end
	end
end
