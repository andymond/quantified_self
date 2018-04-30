FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "testfood#{n}"}
    sequence(:calories) { |n| "testfood#{n * 100}"}
  end
end
