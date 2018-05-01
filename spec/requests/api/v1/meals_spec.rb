require "rails_helper"

describe "Successful API/V1 meal requests" do
  it "can return index of all existing meals" do
    meal_list  = create_list(:meal, 10)
    first_meal = meal_list.first
    last_meal  = meal_list.last

    get "/api/v1/meals"

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_an Array
    expect(results.first[:id]).to eq(first_meal.id)
    expect(results.first[:name]).to eq(first_meal.name)
    expect(results.first[:food]).to be_an Array
    expect(results.first[:food].first[:id]).to eq(first_meal.foods.first.id)
    expect(results.first[:food].first[:name]).to eq(first_meal.foods.first.name)
    expect(results.first[:food].first[:calories]).to eq(first_meal.foods.first.calories)
    expect(results.last[:id]).to eq(last_meal.id)
    expect(results.last[:name]).to eq(last_meal.name)
    expect(results.last[:food]).to be_an Array
    expect(results.last[:food].first[:id]).to eq(last_meal.foods.first.id)
    expect(results.last[:food].first[:name]).to eq(last_meal.foods.first.name)
    expect(results.last[:food].first[:calories]).to eq(last_meal.foods.first.calories)
  end

  it "can return a single meal by id" do
    meal_list  = create_list(:meal, 10)
    meal = meal_list.first

    get "/api/v1/meals/#{meal.id}/foods"

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:id]).to eq(meal.id)
    expect(results[:name]).to eq(meal.name)
    expect(results[:food]).to be_an Array
    expect(results[:food].first[:name]).to eq(meal.foods.first.name)
    expect(results[:food].first[:calories]).to eq(meal.foods.first.calories)
  end

  it "can add a specific food to a meal by ids" do
    meal = create(:meal)
    food = create(:food)

    post "/api/v1/meals/#{meal.id}/foods/#{food.id}"

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results[:message]).to eq("Successfully added #{food.name} to #{meal.name}")
  end

  it "can remove a specific food from a meal by ids" do
    meal = create(:meal)
    food = meal.foods.first

    delete "/api/v1/meals/#{meal.id}/foods/#{food.id}"


    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results[:message]).to eq("Successfully removed #{food.name} from #{meal.name}")
  end
end
