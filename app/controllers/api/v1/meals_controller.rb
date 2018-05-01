class Api::V1::MealsController < ApplicationController

  def index
    render json: Meal.all
  end

  def show
    render json: Meal.find(params[:id])
  end

end
