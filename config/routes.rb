Rails.application.routes.draw do
  scope :auth do
    post '/autologin', to: 'auth#autologin'
    post '/login', to: 'auth#login'
  end
  
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games, only: [:create, :show]
end
