class Book < ApplicationRecord
    # ここはbookの投稿画像の管理用テーブル
    has_one_attached :image

    # ↓があることでuser.rbと1:Nの関係になる
    belongs_to :user

    
end
