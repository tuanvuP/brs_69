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

  resources :follows, only: [:create, :destroy]
  resources :books do
    resources :reviews
  end
  resources :requests

  namespace :admin do
    root "static_pages#index"
    resources :users, :books, :reviews, :requests
  end
end
