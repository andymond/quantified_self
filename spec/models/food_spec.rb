require "rails_helper"

describe Food do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:calories)}
  it {should have_many(:meal_foods)}
  it {should have_many(:meals)}
end
