require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

enable :sessions

set :database, "sqlite3:blogz.db"

require './models'

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
	else
		flash[:alert] = "There was a problem signing you in."
	end
	redirect '/my_page'
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
	Post.create(user: current_user, title: params[:title], body: params[:body])
	redirect '/my_page'
end


