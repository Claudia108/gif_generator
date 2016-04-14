Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, only: [:new, :create]
  resources :gifs, only: [:index]
end
