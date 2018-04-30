class Api::V1::FoodsController < ApplicationController
  before_action :validate_params, only: :create

  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  end

  def create
    food = Food.create(food_params)
    render json: Food.find(food.id)
  end

  private

    def food_params
      params.require(:food).permit(:name, :calories)
    end

    def validate_params
      payload = {error: "missing param"}
      if food_params[:name] === "" || food_params[:calories] === ""
        render json: payload, status: 400
      end
    end

end
