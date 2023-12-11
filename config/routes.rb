Rails.application.routes.draw do

  #findpassword and change root
  post 'findpassword/user_confirm'
  get 'findpassword/user_confirm'
  post 'findpassword/update'
  get 'findpassword/change_password'
  post 'findpassword/new'
 
  #mypage
  get 'mypage/update_name'
  get 'mypage/admin'
  get 'mypage/update_password'

  get 'main/new'
  get 'home/index'
  get 'cookie/new'

  #단어관리
  get 'admins/show/:id' => "admins#show"
  get 'admins/edit/:id' => "admins#edit"
  get 'admins/update/:id' => "admins#update"
  get 'admins/destroy/:id' => "admins#destroy"
  get 'admins/index'
  get 'admins/new'
  get 'admins/create'
  #csv다운로드
  get 'admins/export_to_csv', to: 'admins#export_to_csv'

  #태그루트
  post 'tag/index'
  get 'tag/index'
  post 'tag/new'
  post 'tag/create'
  get 'tag/edit/:id' => "tag#edit"
  get 'tag/update/:id' => "tag#update"
  get 'tag/destroy/:id' => "tag#destroy"
  #버튼
  
   
  #퀴즈 경로
  get 'dictionary/new'
  get '/dictionary/next_question' => 'dictionary#next_question'
  get '/dictionary/ranking' => 'dictionary#ranking'
  #랭킹 경로
  post '/dictionary/ranking', to: 'dictionary#ranking'

  resources :question_similar_words do
    resources :admins
  end

  resources :admins do
    collection do
      post 'create'
    end
  end

  #button_main
  post 'ranking/new'
  post 'dictionary/new'
  post 'users/new'
  post 'home/index'

  post 'admins/index'
  post 'admins/edit'
  post 'admins/update'
  post 'admins/create'
  post 'admins/new'
  post 'admins/tag_create'
  post 'main/new'
  post 'mypage/admin'

  get '/main' => 'main#new'
  post 'cookie/sign_in', to: 'cookie#create'
  delete 'cookie/sign_out', to: 'cookie#destroy'

  #신규유저작성
  resources :users
  

  root 'home#index'
 
end
