require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    recipe = Recipe.find_by_id(params[:id])
    hash = {}
    params.each_pair do |key, value|
      hash[key] = value if key != :id && value != nil
    end
    recipe.update(hash)
    redirect "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.delete
    redirect '/recipes'
  end

end
