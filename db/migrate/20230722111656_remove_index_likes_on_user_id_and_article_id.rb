class RemoveIndexLikesOnUserIdAndArticleId < ActiveRecord::Migration[7.0]
  def up
    remove_index :likes, name: "index_likes_on_user_id_and_article_id" if index_name_exists?(:likes, "index_likes_on_user_id_and_article_id")
  end

  def down
    add_index :likes, :user_id, unique: true, name: "index_likes_on_user_id_and_article_id" unless index_exists?(:likes, "index_likes_on_user_id_and_article_id")
  end
end