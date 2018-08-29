Rails.application.routes.draw do
  resources :ideas
  post '/signup', to: 'user_token#create'
end
