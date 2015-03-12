Rails.application.routes.draw do
  resources :links

  resources :queries

  root to: 'visitors#index'
  devise_for :users
end
