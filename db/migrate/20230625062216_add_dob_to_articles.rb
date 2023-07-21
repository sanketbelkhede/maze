class AddDobToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :dob, :date
  end
end
