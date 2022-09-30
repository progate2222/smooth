json.extract! task, :id, :title, :description, :time_limit, :importance, :completion_flag, :memo, :created_at, :updated_at
json.url task_url(task, format: :json)
