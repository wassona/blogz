

class Post < ActiveRecord::Base
	belongs_to :user
end

class Profile < ActiveRecord::Base
	belongs_to :user
end

class UserFollower < ActiveRecord::Base
	belongs_to :user
	belongs_to :follower, :class_name => 'User'
end

class User < ActiveRecord::Base
	has_one :profile
	has_many :posts
	has_many :followers, :class_name => 'UserFollower', :foreign_key => 'user_id'
	has_many :followings, :class_name => 'UserFollower', :foreign_key => 'follower_id'
end