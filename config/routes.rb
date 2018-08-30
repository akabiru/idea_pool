Rails.application.routes.draw do
  resources :ideas
  resources :users, only: :create
  get '/me', to: 'users#me'
  post '/access-tokens/refresh', to: 'sessions#refresh'
  post '/access-tokens', to: 'sessions#create'
  delete '/access-tokens', to: 'sessions#destroy'
end
