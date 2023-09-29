Rails.application.routes.draw do
  resources :users
  get 'home/index'
  get 'cookie/new'
  post 'cookie/sign_in', to: 'cookie#create'
  delete 'cookie/sign_out', to: 'cookie#destroy'

  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
