class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/' do
    @recipes = Recipe.all
    erb :index
  end

  # index displays all articles
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # new displays create recipe form
  get '/recipes/new' do
    erb :new
  end

  #create creates one recipe
  post "/recipes" do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  #show displays one recipe based on ID in the url
  get "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  # edit displays edit form based on ID in the url
  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  #update modifies an existing recipe based on ID in the url
  patch "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    #binding.pry
    @recipe.name=params["name"]
    @recipe.ingredients=params["ingredients"]
    @recipe.cook_time=params["cook_time"]
    @recipe.update
    redirect to "/recipes/#{@recipe.id}"
  end

  # delete
  delete "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    #binding.pry
    redirect to "/recipes"
  end


end
