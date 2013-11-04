json.array!(@products) do |product|
  json.extract! product, :product_number, :name, :width, :height, :depth, :weight, :stock_level
  json.url product_url(product, format: :json)
end
