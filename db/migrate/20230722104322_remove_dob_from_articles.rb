class RemoveDobFromArticles < ActiveRecord::Migration[7.0]
  def up
    remove_column :articles, :dob if column_exists?(:articles, :dob)
  end

  def down
    add_column :articles, :dob, :date unless column_exists?(:articles, :dob)
  end
end
