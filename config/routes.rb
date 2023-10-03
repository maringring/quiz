Rails.application.routes.draw do
  get '/searches/result' => 'searches#result'
  get 'admins/index'
  get 'admins/new'
  get 'admins/create'
  get 'admins/show/:id' => "admins#show"
  get 'admins/edit/:id' => "admins#edit"
  get 'admins/update/:id' => "admins#update"
  get 'admins/destroy/:id' => "admins#destroy"
  get 'ranking/new'
  get 'dictionary/new'

  resources :users, :questions, :questin_similar_words, :admins
  get 'main/new'
  get 'home/index'
  get 'cookie/new'

  #시험삼아 만든 경로
  resources :questin_similar_words do
    resources :admins
  end

  #button_main
  post 'ranking/new'
  post 'dictionary/new'
  post 'users/new'
  post 'admins/index'
  post 'admins/create'
  post 'admins/new'
  post 'main/new'

  get '/main' => 'main#new'
  post 'cookie/sign_in', to: 'cookie#create'
  delete 'cookie/sign_out', to: 'cookie#destroy'

  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
