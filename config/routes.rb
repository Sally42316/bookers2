Rails.application.routes.draw do
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'


  devise_for :users
  root to: "homes#top"
  get "home/about", to: "homes#about"
  resources :users, only: [:index, :show, :edit, :update, :create]
  resources :books, only: [:new, :index, :show, :create, :edit, :destroy, :update]

  # ↓これでコメント投稿のルーティングを設定ができる
  resources :books, only: [:new, :create, :index, :show, :destroy] do
    resources :book_comments, only: [:create, :destroy]
  end

  get 'users/edit'

  # ↓headerのAboutリンクをつくりたくて
  get 'home/about', to: 'homes#about'
  get 'book/index', to: 'books#index'
  # get '/about', to: 'controller#action'
  get '/about', to: 'homes#about'
end