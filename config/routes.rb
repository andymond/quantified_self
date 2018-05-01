Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :foods, only: [:index, :show, :create, :update, :destroy]
      resources :meals, only: [:index] do
        post 'foods/:id', to: 'meal_foods#create'
      end
      get '/meals/:id/foods', to: 'meals#show'
    end
  end
end
