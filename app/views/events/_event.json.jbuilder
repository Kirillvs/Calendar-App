json.extract! event, :id, :name, :description, :start, :repetitive, :repeat_period, :created_at, :updated_at
json.url event_url(event, format: :json)
