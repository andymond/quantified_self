class Api::V1::FoodsController < ApplicationController
  before_action :find_food, only: [:show, :update, :destroy]
  before_action :validate_params, only: :create

  def index
    render json: Food.all
  end

  def show
    render json: @food
  end

  def create
    food = Food.create(food_params)
    render json: Food.find(food.id)
  end

  def update
    @food.update(food_params)
    render json: Food.find(@food.id)
  end

  def destroy
    @food.destroy
    render json: {success: "#{@food.name} deleted."}
  end

  private

    def find_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:name, :calories)
    end

    def validate_params
      payload = {error: "missing param"}
      if food_params[:name].nil? || food_params[:calories].nil?
        render json: payload, status: 400
      end
    end

end
