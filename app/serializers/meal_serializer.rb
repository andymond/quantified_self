class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :food

  def food
    object.foods.all
  end

end
