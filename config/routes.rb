Rails.application.routes.draw do



  namespace :api do
    resource :table_user_authorization_tokens, only: [:index], controller: 'api'
    resources :table_users, only:[ :create ], controller: 'api'
  end




end
