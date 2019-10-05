require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require "sinatra"
require 'sinatra/activerecord'
require_relative './lib/bookmark'
require_relative './database_connection_setup.rb'
require_relative './lib/comment'
require_relative './lib/tag'
require_relative './lib/user'
require_relative './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    erb :'main_page'
  end

  get '/bookmarks' do
    @user = User.find(id: session[:user_id])
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    flash[:notice] = "Please submit a valid URL" unless Bookmark.create(url: params[:url], title: params[:title], owner_id: session[:user_id])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Tag.delete_with_bookmark(id: params[:id]) 
    Comment.delete_with_bookmark(id: params[:id])
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id/comments' do
    Comment.delete(id: params[:id])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id/tags' do
    Tag.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :"bookmarks/edit"
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url], owner_id: session[:user_id])
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(bookmark_id: params[:id], text: params[:comment])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params[:id]
    erb :'/tags/new'
  end

  post '/bookmarks/:id/tags' do
    Tag.create(bookmark_id: params[:id], content: params[:tag])
    redirect '/bookmarks'
  end

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    user = User.create(email: params['email'], password: params['password'])
    session[:user_id] = user.id
    redirect '/bookmarks'
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect('/bookmarks')
    else
      flash[:notice] = 'Please check your email or password.'
      redirect('/sessions/new')
    end
  end

  post '/sessions/destroy' do
    session.clear
    #flash[:notice] = 'You have signed out.'
    redirect('/')
  end

  run! if app_file == $0
end