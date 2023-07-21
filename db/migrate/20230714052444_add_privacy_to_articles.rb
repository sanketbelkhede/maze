class AddPrivacyToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :privacy, :boolean, default: false
  end
end
