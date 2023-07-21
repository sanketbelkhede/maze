class AddMobileNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mobile, :integer
    add_column :users, :name, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :password_confirmation, :string

  end
end
