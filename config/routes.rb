Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, only: [:new, :create]
  resources :gifs, only: [:index]

  namespace :admin do
    resources :categories, only: [:index]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
