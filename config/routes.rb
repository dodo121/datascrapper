Rails.application.routes.draw do
  resources :queries

  root to: 'visitors#index'
  devise_for :users
end
