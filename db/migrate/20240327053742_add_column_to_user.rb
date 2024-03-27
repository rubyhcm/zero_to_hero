class AddColumnToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nickname, :string
    add_column :users, :image_url, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
