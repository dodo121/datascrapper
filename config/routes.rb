require 'sidekiq/web'

Rails.application.routes.draw do
  resources :links

  resources :queries

  root to: 'queries#index'
  devise_for :users
  mount Sidekiq::Web, at: '/sidekiq'
end
