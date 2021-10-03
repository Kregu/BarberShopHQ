require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

set :database, adapter: 'sqlite3', database: 'barbershop.db'

class Client < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :phone, presence: true, length: { minimum: 7 }
  validates :datestamp, presence: true
  validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

before do
  @barbers = Barber.all
end

get '/' do
  erb :index
end

get '/visit' do
  @c = Client.new
  erb :visit
end

get '/barber/:id' do
  @barber = Barber.find params[:id]
  erb :barber
end

get '/bookings' do
  @client = Client.order 'created_at DESC'
  erb :bookings
end

get '/client/:id' do
  @client = Client.find params[:id]
  erb :client
end

post '/visit' do
  @c = Client.new params[:client]

  if @c.save
    erb '<h3>Thank you! You are signed up.</h3>'
  else
    @error = @c.errors.full_messages.first
    erb :visit
  end
end
