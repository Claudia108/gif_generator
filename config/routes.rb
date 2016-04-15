Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, only: [:new, :create]
  resources :gifs, only: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
