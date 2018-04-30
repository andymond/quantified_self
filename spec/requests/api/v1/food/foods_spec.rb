require "rails_helper"

describe "successful API/V1 requests" do
  it "can return index of all existing foods" do
    create_list(:food, 10)

    get "/api/v1/foods"

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_an Array
    expect(results.count).to eq(10)
    expect(results.first[:id]).to eq(1)
    expect(results.first[:name]).to eq('testfood1')
    expect(results.first[:calories]).to eq(100)
    expect(results.last[:id]).to eq(10)
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
    expect(results[:calories]).to eq(food_1.calories)
  end

  it "can create food with appropriate attributes" do
    params = {:food => {:name => "test1", :calories => 100}}
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post "/api/v1/foods", params: params.to_json, headers: headers

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:name]).to eq("test1")
    expect(results[:calories]).to eq(100)
  end

  it "can update all attributes of exisiting foods" do
    food = create(:food)

    params = {:food => {:name => "flan", :calories => 10000}}
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    patch "/api/v1/foods/#{food.id}", params: params.to_json, headers: headers

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:name]).to eq("flan")
    expect(results[:calories]).to eq(10000)
  end

  it "can update one attribute of exisiting foods" do
    food = create(:food)

    params = {:food => {:calories => 10000}}
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    patch "/api/v1/foods/#{food.id}", params: params.to_json, headers: headers

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:name]).to eq(food.name)
    expect(results[:calories]).to eq(10000)
  end

  it "can delete existing foods" do
    food_1 = create(:food)
    create(:food)

    delete "/api/v1/foods/#{food_1.id}"

    expect(response).to be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results[:success]).to eq("#{food_1.name} deleted.")
    expect(Food.all.count).to eq(1)
  end
end

describe "Unsuccessful API/V1 requests" do
  it "tries to see non-existent food" do
    get "/api/v1/foods/100"

    expect(response).to_not be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:error]).to eq("record not found")
  end

  it "tries to update non-existent food" do
    patch "/api/v1/foods/100"

    expect(response).to_not be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:error]).to eq("record not found")
  end

  it "tries to delete non-existent food" do
    patch "/api/v1/foods/100"

    expect(response).to_not be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:error]).to eq("record not found")
  end

  it "tries to create food without required attributes" do
    params = {:food => {:calories => 10000}}
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post "/api/v1/foods", params: params.to_json, headers: headers

    expect(response).to_not be_success

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    expect(results[:error]).to eq("missing param")
  end
end
