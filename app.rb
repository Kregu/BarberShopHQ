#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	include ActiveRecord::Persistence
end

class Barber < ActiveRecord::Base
	include ActiveRecord::Persistence

end

get '/' do
	erb :index
end
