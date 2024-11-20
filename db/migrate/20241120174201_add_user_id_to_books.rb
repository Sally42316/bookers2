class AddUserIdToBooks < ActiveRecord::Migration[6.1]
  def change
    # add_column :books, :user_id, :integer
    # add_index :books, :user_id
    add_reference :books, :user, null: false, foreign_key: true
  end
end
