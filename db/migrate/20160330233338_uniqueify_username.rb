class UniqueifyUsername < ActiveRecord::Migration
  def change
    remove_column :users, :username, :string
    add_column :users, :username, :string, null: false, unique: true
  end
end
