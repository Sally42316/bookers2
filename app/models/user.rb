class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

     
       # ↓があることでbook.rbと1:Nの関係になる
   has_many :post_images, dependent: :destroy
 
 
   # UserモデルとBookモデルの間に1対多の関連付けを定義します。Userが多数のBookを持つ関係なので、Userモデルに`has_many :books`を追加し、Bookモデルには`belongs_to :user`を追加します。
   has_many :books

  # バリテーション↓
  validates :name, length: { in: 2..20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

   # ↓userモデルにnameとpositionに加えて画像を扱うためのimageカラムが追記されたかのように扱うことができます。
  has_one_attached :profile_image
  
  # ↓これでコメントが1:Nでつくようになる
  has_many :book_comments, dependent: :destroy

  # ↓これでいいね機能がつかえる
  has_many :favorites, dependent: :destroy

   # ↓ユーザーの画像を表示する
  #  has_one_attached :profile_image
 
   def get_profile_image(width, height)
     unless profile_image.attached?
       file_path = Rails.root.join('app/assets/images/default-image.jpg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
     profile_image.variant(resize_to_limit: [100, 100]).processed
   end

   # フォローをした、されたの関係
has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
# フォローをした、されたの関係で一覧画面で使う
has_many :followings, through: :relationships, source: :followed
has_many :followers, through: :reverse_of_relationships, source: :follower

# フォローしたときの処理
def follow(user_id)
  relationships.create(followed_id: user_id)
end
# フォローを外すときの処理
def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
end
# フォローしているか判定
def following?(user)
  followings.include?(user)
end

# 検索方法分岐
def self.search_for(content, method)
  if method == 'perfect'
    User.where(name: content)
  elsif method == 'forward'
    User.where('name LIKE ?', content + '%')
  elsif method == 'backward'
    User.where('name LIKE ?', '%' + content)
  else
    User.where('name LIKE ?', '%' + content + '%')
  end
end
 

 
 # `User`モデルに`introduction`というカラムが存在しない場合、`introduction`メソッドを追加して値を返すように定義します。
 #  def introduction
 #  end
 
 end