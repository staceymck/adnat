Rails.application.routes.draw do
  root 'sessions#new'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'

  resources :users, except: [:new, :create, :destroy, :index]
end
