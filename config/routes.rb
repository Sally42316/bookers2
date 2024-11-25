Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'


  devise_for :users
  root to: "homes#top"
  get "home/about", to: "homes#about"
  resources :users, only: [:index, :show, :edit, :update, :create]


  # ↓これでコメント投稿のルーティングを設定ができる
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get 'users/edit'

  # follow,follwedの関係でネストさせる
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # ↓headerのAboutリンクをつくりたくて
  get 'home/about', to: 'homes#about'
  get 'book/index', to: 'books#index'
  # get '/about', to: 'controller#action'
  get '/about', to: 'homes#about'
end