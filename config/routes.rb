Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "home/about", to: "homes#about"
  resources :users, only: [:index, :show, :edit, :update, :create]
  resources :books, only: [:new, :index, :show, :create, :edit, :destroy, :update]

  get 'users/edit'

  # ↓ヘッダーのAboutリンクをつくりたくて
  get 'home/about', to: 'homes#about'
  get 'book/index', to: 'books#index

  
  Rails.application.routes.draw do
  get 'about', to: 'homes#about', as: 'about'
    
  end

end


# application.html.erbで`about_path`を使用できるようにしたもの↓
# 上記のように設定することで'/about'にアクセスしたときにhomesコントローラーのaboutアクションが呼ばれるようになり、名前付きルート'about_path'が生成されます。