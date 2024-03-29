class AddTagsToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :tags, :text, array: true, default: []
  end
end
