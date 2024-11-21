class Book < ApplicationRecord
    # ここはbookの投稿画像の管理用テーブル
    has_one_attached :image

    # ↓があることでuser.rbと1:Nの関係になる
    belongs_to :user

    validates :title, length: { in: 2..20 }, uniqueness: true
    validates :introduction, length: { maximum: 50 }
end
