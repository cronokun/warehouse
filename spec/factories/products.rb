# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    product_number 1
    name "MyString"
    width 1
    height 1
    depth 1
    weight 1
    stock_level 1
  end
end
