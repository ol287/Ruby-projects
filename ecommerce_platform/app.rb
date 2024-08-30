# app.rb
require 'sinatra'
require 'erb'
require_relative 'models/product'
require_relative 'models/user'
require_relative 'models/cart'
require_relative 'models/order'
require_relative 'models/database'

# Set up the database and load products
db = Database.new
db.load_sample_data

# Session configuration
enable :sessions

# Home page route
get '/' do
  @products = db.all_products
  erb :index
end

# Product page route
get '/product/:id' do
  @product = db.find_product(params[:id].to_i)
  erb :product
end

# Add product to cart route
post '/cart/add/:id' do
  product = db.find_product(params[:id].to_i)
  session[:cart] ||= Cart.new
  session[:cart].add_product(product)
  redirect '/'
end

# View cart route
get '/cart' do
  @cart = session[:cart]
  erb :cart
end

# Place order route
post '/order' do
  @cart = session[:cart]
  if @cart
    @order = Order.new(@cart)
    db.add_order(@order)
    session[:cart] = nil
    erb :order
  else
    redirect '/cart'
  end
end
