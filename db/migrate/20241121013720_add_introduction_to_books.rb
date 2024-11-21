class AddIntroductionToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :introduction, :string
  end
end
