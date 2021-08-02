Rails.application.routes.draw do
  root 'sessions#new'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'

  post '/join', to: 'memberships#create'
  delete '/leave', to: 'memberships#destroy'

  resources :users, except: [:new, :create, :destroy, :index] 
  resources :organisations, except: [:index, :show, :new] do
    resources :shifts, only: [:index]
  end

  resources :shifts, except: [:index, :show]
end
