json.array!(@tasks) do |task|
  json.extract! task, :description, :completed
  json.url task_url(task, format: :json)
end
