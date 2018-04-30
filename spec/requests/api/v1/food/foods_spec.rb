require "rails_helper"

describe "API/V1" do
  it "can return index of all existing foods" do
    create_list(:food, 10)

    get 'api/v1/foods'

    results = JSON.parse(response, symbolize_names: true)

    expect(results.count).to eq(10)
    expect(results.first.name).to eq('testfood1')
    expect(results.first.calories).to eq('100')
    expect(results.last.calories).to eq('testfood10')
    expect(results.last.calories).to eq('1000')
  end
end
