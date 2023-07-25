class AddIndexLikesOnEntityUser < ActiveRecord::Migration[7.0]
  def up
    remove_index :likes, name: "index_likes_on_user_id" if index_name_exists?(:likes, "index_likes_on_user_id")
    add_index :likes, [:user_id, :entity_type, :entity_id], unique: true, name: "index_likes_on_entity_user" unless index_exists?(:likes, "index_likes_on_entity_user")
  end

  def down
    add_index :likes, :user_id, unique: false, name: "index_likes_on_user_id" unless index_exists?(:likes, "index_likes_on_user_id")
    remove_index :likes, name: "index_likes_on_entity_user" if index_name_exists?(:likes, "index_likes_on_entity_user")
  end
end
