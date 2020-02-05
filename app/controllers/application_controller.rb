class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    #binding.pry 
    erb :'index'
  end #get /articles

  get '/recipes/new' do
    erb :'new'
  end # get /recipes/new

  post '/recipes' do
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end #post /recipes

  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :'show'
  end #get /recipes/:id

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    @name = @recipe.name
    @ingredients = @recipe.ingredients
    @cook_time = @recipe.cook_time
    erb :'edit'
  end #get /recipes/:id/edit

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end #patch /recipes/:id 

  delete '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.delete 
  end #delete /recipes/:id 

end
