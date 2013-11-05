# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :product_number do |n|
    "ABC #{rand(100..999)}#{n}00-#{rand(1000..9999)}-#{rand(10..99)}"
  end

  factory :product do
    product_number
    name { Faker::Commerce.product_name }
    width 50
    height 100
    depth 50
    weight 10
    stock_level 1
  end
end
