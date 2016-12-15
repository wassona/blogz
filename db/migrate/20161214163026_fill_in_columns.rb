class FillInColumns < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :username, :string
  	add_column :users, :email, :string
  	add_column :users, :password, :string
  	add_column :users, :profile_id, :integer
  	add_column :users, :post_id, :integer
  	add_column :users, :active, :boolean

  	add_column :posts, :user_id, :integer
  	add_column :posts, :created_at, :datetime
  	add_column :posts, :title, :string
  	add_column :posts, :body, :string

  	add_column :profiles, :user_id, :integer
  	add_column :profiles, :body, :string

  	add_column :user_followers, :leader_id, :integer
  	add_column :user_followers, :follower_id, :integer

  end
end
