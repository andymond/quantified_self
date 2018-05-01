FactoryBot.define do
  factory :meal do
    sequence(:name) { |n| "meal_name#{n}"}

    after(:create) do |meal|
      food = create(:food)
      MealFood.create(food_id: food.id, meal_id: meal.id)
    end
  end
end
