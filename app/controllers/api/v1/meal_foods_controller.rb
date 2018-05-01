class Api::V1::MealFoodsController < ApplicationController

  def create
    MealFood.create(meal_id: params[:meal_id], food_id: params[:id])
    food = Food.find(params[:id])
    meal = Meal.find(params[:meal_id])
    payload = {message: "Successfully added #{food.name} to #{meal.name}"}
    render json: payload
  end

end
