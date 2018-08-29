Rails.application.routes.draw do
  resources :ideas
  resources :users, only: :create
  get '/me', to: 'users#me'
end
