
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect "articles/#{@article.id}"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id].to_i)
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id].to_i)
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id].to_i)
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    erb :show
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id].to_i)
    @article.destroy
    @articles = Article.all
    erb :index
  end
end
