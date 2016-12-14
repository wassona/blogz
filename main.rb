require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

enable :sessions

set :database, "sqlite3:blogz.db"

require './models'