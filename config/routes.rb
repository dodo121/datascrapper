Rails.application.routes.draw do
  resources :links

  resources :queries

  root to: 'queries#index'
  devise_for :users
end
