json.array!(@games) do |game|
  json.extract! game, :id, :name, :port
  json.url game_url(game, format: :json)
end
