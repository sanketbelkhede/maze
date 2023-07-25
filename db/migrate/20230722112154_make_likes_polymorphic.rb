class MakeLikesPolymorphic < ActiveRecord::Migration[7.0]
  def up
    add_reference :likes, :entity, polymorphic: true, index: true
  end

  def down
    remove_reference :likes, :entity, polymorphic: true, index: true
  end
end
