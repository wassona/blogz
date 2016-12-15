

class Post < ActiveRecord::Base
	belongs_to :user 
end

class Profile < ActiveRecord::Base
	belongs_to :user
end

class User < ActiveRecord::Base
	has_one :profile, dependent: :delete
	has_many :posts, dependent: :destroy

	has_and_belongs_to_many :followers,
		class_name: "User",
		foreign_key: "leader_id",
		association_foreign_key: "follower_id",
		join_table: :user_followers

	has_and_belongs_to_many :leaders,
		class_name: "User",
		foreign_key: "follower_id",
		association_foreign_key: "leader_id",
		join_table: :user_followers
end