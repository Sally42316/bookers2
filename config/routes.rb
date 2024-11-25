Rails.application.routes.draw do
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

  # ↓headerのAboutリンクをつくりたくて
  get 'home/about', to: 'homes#about'
  get 'book/index', to: 'books#index'
  # get '/about', to: 'controller#action'
  get '/about', to: 'homes#about'
end