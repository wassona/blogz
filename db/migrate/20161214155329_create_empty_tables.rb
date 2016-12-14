class CreateEmptyTables < ActiveRecord::Migration[5.0]
  def change
  	create_table :users
  	create_table :posts
  	create_table :profiles
  	create_table :user_followers
  end
end
