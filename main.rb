require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'


enable :sessions

# set :database, "sqlite3:blogz.db"

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

require './models'
require './colors'

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

get '/' do
	erb :index
end

get '/login' do
	erb :login
end

post '/login' do
	@user = User.where(username: params[:username]).first
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "You've been signed in successfully!"
		redirect '/my_page'
	else
		flash[:alert] = "There was a problem signing you in."
		redirect '/'
	end
end

get '/register' do
	erb :register
end

post '/register' do
	@user = User.create (params[:user])
	if @user.username == User.last.username       #this line might not be scalable
		flash[:notice] = "You've registered successfully! Please log in."
		redirect '/login'
	else
		flash[:alert] = "There was an issue with your registration. Please try again."
		redirect '/register'
	end
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end

get '/my_page' do
	@user = current_user
	erb :my_page
end

post '/profile' do
	@user = current_user
	puts "check"
	puts params[:body]
	puts "check"
	if current_user.profile
		current_user.profile.delete
	end
	Profile.create(user: current_user, body: params[:body])
	current_user.profile
	redirect '/my_page'
end

post '/blog' do
	if params[:title] != "" || params[:body] != ""
		Post.create(user: current_user, title: params[:title], body: params[:body])
	end
	redirect '/my_page'
end

post '/update_post' do
	if params[:title] != "" || params[:body] != ""
		Post.find(params[:post_id]).update_attributes(title: params[:title], body: params[:body])
	end
	redirect '/my_page'
end

post '/delete_post' do
	Post.find(params[:post_id]).delete
	redirect '/my_page'
end

get '/user_view/:id' do
	@view = User.find(params[:id])
	erb :user_view
end

post '/unfollow' do
	current_user.leaders.delete(params[:view])
	redirect '/user_view/' + (params[:view])
end

post '/follow' do
	current_user.leaders.push(User.find(params[:view]))
	redirect '/user_view/' + params[:view]
end

post '/delete_account' do
	current_user.destroy
	redirect '/logout'
end













