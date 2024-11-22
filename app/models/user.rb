class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリテーション↓
  validates :name, length: { in: 2..20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

   # ↓userモデルにnameとpositionに加えて画像を扱うためのimageカラムが追記されたかのように扱うことができます。
  has_one_attached :profile_image


   # ↓ユーザーの画像を表示する
   has_one_attached :profile_image
 
   def get_profile_image(width, height)
     unless profile_image.attached?
       file_path = Rails.root.join('app/assets/images/default-image.jpg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
     profile_image.variant(resize_to_limit: [100, 100]).processed
   end
 
 
       # ↓があることでbook.rbと1:Nの関係になる
   has_many :post_images, dependent: :destroy
 
 
   # UserモデルとBookモデルの間に1対多の関連付けを定義します。Userが多数のBookを持つ関係なので、Userモデルに`has_many :books`を追加し、Bookモデルには`belongs_to :user`を追加します。
   has_many :books
 
 # `User`モデルに`introduction`というカラムが存在しない場合、`introduction`メソッドを追加して値を返すように定義します。
 #  def introduction
 #  end
 
 end