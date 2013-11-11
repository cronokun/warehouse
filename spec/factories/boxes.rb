FactoryGirl.define do
  factory :box do
    sequence(:name) { |n| "Box-#{n}"}
    volume 1
  end
end
