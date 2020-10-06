Rails.application.routes.draw do
  root "top#index"
  get "home/about" => "about#index"
  devise_for :users
  resources :users, only: [:show, :edit, :update, :index ] do
    member do
      get :following, :followers
    end
  end
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  
  get "search" => "search#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end