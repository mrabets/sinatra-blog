require 'rubygems'
require 'sinatra'
require 'sqlite3'

configure do
  $db = SQLite3::Database.new 'base.db'
  $db.execute 'CREATE TABLE IF NOT EXISTS "Posts"
    (
      "Id"	INTEGER,
      "Title"	TEXT,
      "Content"	TEXT,
      PRIMARY KEY("Id" AUTOINCREMENT)
    )'
end

helpers do
  require './my_methods'
end

get '/' do
  erb :posts
end

get '/add_post' do
  erb :add_post
end

post '/add_post' do
  @title = params[:title]
  @content = params[:content]

  $db.execute 'INSERT INTO Posts(Title, Content) VALUES (?, ?)', [@title, @content]

  erb "Your title: #{@title}\ncontent: #{@content}"
end

get '/posts' do
  erb :posts
end

get '/post/:post_id' do
  @post_id = params[:post_id]
  erb :post_page
end
