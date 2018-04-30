FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "testfood#{n}" }
    sequence(:calories) { |n| n * 100 }
  end
end
