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

    # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
end
