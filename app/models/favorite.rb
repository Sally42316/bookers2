class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :book

    # ↓これで一人１かいのいいね！制限ができる
    validates :user_id, uniqueness: {scope: :book_id}
end
