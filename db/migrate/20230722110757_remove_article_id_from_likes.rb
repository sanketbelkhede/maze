class RemoveArticleIdFromLikes < ActiveRecord::Migration[7.0]
  def up
    remove_reference :likes, :article if column_exists?(:likes, :article_id)
  end

  def down
    add_reference :likes, :article unless column_exists?(:likes, :article_id)
  end
end
