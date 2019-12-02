Rails.application.routes.draw do
  resources :posts
  resources :comments
  resources :friendships
  resources :users
  resources :sessions

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  post "/logout" => "sessions#destroy"
  get "users/:id/friends" => "users#friend_page", as: :user_friends

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
