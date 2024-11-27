class Book < ApplicationRecord
    # ここはbookの投稿画像の管理用テーブル
    # has_one_attached :image

    # ↓があることでuser.rbと1:Nの関係になる
    belongs_to :user

    # ↓これでコメントが付くようになる
    has_many :book_comments, dependent: :destroy

    # ↓これでお気に入り機能がつく
    has_many :favorites, dependent: :destroy
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end

    # バリテーション↓
    validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }

    # ↓検索機能
    def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end


end
