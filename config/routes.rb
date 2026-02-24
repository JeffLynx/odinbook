Rails.application.routes.draw do
  get "follows/create"
  get "follows/destroy"
  get "posts/index"
  devise_for :users

  resources :posts do
    resources :likes, only: [ :create, :destroy ]
    resources :comments, only: [ :create, :destroy ]
  end

  resources :follows, only: [ :create, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check


  root "posts#index"
end
