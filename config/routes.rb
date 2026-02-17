Rails.application.routes.draw do
  get "posts/index"
  devise_for :users

  resources :posts, only: [ :index, :create ]

  get "up" => "rails/health#show", as: :rails_health_check


  root "posts#index"
end
