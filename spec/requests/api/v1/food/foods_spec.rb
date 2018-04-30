require "rails_helper"

describe "API/V1" do
  it "can return index of all existing foods" do
    create_list(:food, 10)

    get "/api/v1/foods"

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results.count).to be_an Array
    expect(results.count).to eq(10)
    expect(results.first[:name]).to eq('testfood1')
    expect(results.first[:calories]).to eq(100)
    expect(results.last[:name]).to eq('testfood10')
    expect(results.last[:calories]).to eq(1000)
  end

  it "can return a single food by id" do
    food_1 = create(:food)

    get "/api/v1/foods/#{food_1.id}"

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:name]).to eq(food_1.name)
    expect(results[:calories]).to eq(food_2.name)
  end
end
