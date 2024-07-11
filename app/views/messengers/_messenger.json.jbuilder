json.extract! messenger, :id, :phone_number, :body, :created_at, :updated_at
json.url messenger_url(messenger, format: :json)
