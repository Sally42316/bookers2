class Book < ApplicationRecord
    # ここはbookの投稿画像の管理用テーブル
    # has_one_attached :image

    # ↓があることでuser.rbと1:Nの関係になる
    belongs_to :user

    # ↓これでコメントが付くようになる
    has_many :book_comments, dependent: :destroy

    # バリテーション↓
    validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }
end
