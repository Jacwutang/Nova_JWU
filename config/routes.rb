Rails.application.routes.draw do
  resources :table_user_authorization_tokens
  resources :table_users
  resources :user_authorization_tokens
  resources :users

end
