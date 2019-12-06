Rails.application.routes.draw do
  resources :notifications, only: :index
  resources :posts, except: [:new, :index] do
    resources :likes, only: [:create, :destroy]
  end

  resources :conversations do
    resources :messages, only: [:index, :create]
  end

  resources :comments, except: [:show, :new, :index]
  resources :friendships, only: [:create, :update, :destroy]
  resources :users
  resources :sessions, only: :destroy

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "users/:id/friends" => "users#friend_page", as: :user_friends
  get "users/:id/mutual-friends" => "users#mutual", as: :mutual_friends
  get "users/:id/friend_requests" => "users#friend_requests", as: :friend_requests

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
