Rails.application.routes.draw do
  post '/signup', to: 'user_token#create'
end
