class Api::V1::MealFoodsController < ApplicationController

  def create
    MealFood.create(meal_id: params[:meal_id], food_id: params[:id])
    payload = {message: "Successfully added #{food.name} to #{meal.name}"}
    render json: payload
  end

  def destroy
    mf = MealFood.find_by(meal_id: params[:meal_id], food_id: params[:id])
    mf.destroy
    payload = {message: "Successfully removed #{food.name} from #{meal.name}"}
    render json: payload
  end

  private

    def food
      Food.find(params[:id])
    end

    def meal
      Meal.find(params[:meal_id])
    end

end
