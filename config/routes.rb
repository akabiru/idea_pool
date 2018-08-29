Rails.application.routes.draw do
  resources :ideas
  resources :users, only: :create
end
