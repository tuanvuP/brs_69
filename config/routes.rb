Rails.application.routes.draw do

  root "static_pages#home"
  get "sessions/new"
  get "users/new"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users

  resources :follows, only: [:create, :destroy]
end
