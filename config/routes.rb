Rails.application.routes.draw do
  resources :ideas
  resources :users, only: :create
  get '/me', to: 'users#me'
  post '/access-tokens/refresh', to: 'refresh#create'
  post '/access-tokens', to: 'users#login'
end
