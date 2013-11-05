json.array!(@boxes) do |box|
  json.extract! box, :name, :volume
  json.url box_url(box, format: :json)
end
