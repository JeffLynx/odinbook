Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :likes, only: [ :create, :destroy ]
    resources :comments, only: [ :create, :destroy ]
  end

  resources :follows, only: [ :create, :destroy, :index ] do
    member do
      patch :accept
      delete :reject
    end
  end

  resources :users, only: [ :index, :show ]

  get "up" => "rails/health#show", as: :rails_health_check

  root "posts#index"
end
