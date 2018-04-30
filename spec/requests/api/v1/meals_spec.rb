require "rails_helper"

describe "Successful API/V1 meal requests" do
  it "can return index of all existing meals" do
    meal_list  = create_list(:meal, 10)
    first_meal = meal_list.first
    last_meal  = meal_list.last

    get "/api/v1/meals"

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_name: true)

    expect(results).to be_an Array
    expect(results.first[:id]).to eq(first_meal.id)
    expect(results.first[:name]).to eq(first_meal.name)
    expect(results.first[:food]).to be_an Array
    expect(results.first[:food].first).to eq(first_meal.foods.first)
    expect(results.last[:id]).to eq(last_meal.id)
    expect(results.last[:name]).to eq(last_meal.name)
    expect(results.last[:food]).to be_an Array
    expect(results.last[:food].first).to eq(last_meal.foods.first)
  end
end
