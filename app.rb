#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
    validates :name, presence: true
    validates :phone, presence: true
    validates :datestamp, presence: true
    validates :color, presence: true
end

class Barber < ActiveRecord::Base
	# include ActiveRecord::Persistence
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
  erb :visit
end

post '/visit' do
  
  # @barber = params[:barber]
  # @client_name = params[:client_name]
  # @client_phone = params[:client_phone]
  # @date_time = params[:date_time]
  # @color = params[:color]

  # @client_name.capitalize!

  # #name, phone, datestamp, barber, color

  # c = Client.new
  # c.name = @client_name
  # c.phone = @client_phone
  # c.datastamp = @date_time
  # c.barber = @barber
  # c.color = @color
  # c.save

  c = Client.new params[:client]
  c.save

  if c.save
    erb "<h3>Thank you! You are signed up.</h3>"
  else
    @error = c.errors.full_messages.first
    erb :visit
  end

end
