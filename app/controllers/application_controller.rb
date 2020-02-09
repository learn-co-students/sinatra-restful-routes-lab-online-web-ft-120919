require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes/new' do
    erb :new
    
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect("/recipes/#{@recipe.id}")
  end

  get '/recipes' do
    # recipe_name =  "Bomb.com Mac and Cheese"
    # recipe_ingredients = "milk, butter, cheese, elbow pasta" 
    # recipe_cook_time = "20 minutes" 
    # @recipe1 = Recipe.create(:name => recipe_name, :ingredients => recipe_ingredients, :cook_time => recipe_cook_time)
    # @recipe2 = Recipe.create(:name => "waldorf salad", :ingredients => "apples, cabbage, oil, vinegar", :cook_time => "0")
    @recipes = Recipe.all
    erb :index
    # binding.pry
  end
  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :recipe
    
  end

  delete '/recipes/:id' do
    Recipe.find_by(id: params[:id]).destroy
    redirect('/recipes')

    
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit    
  end
  
  patch '/recipes/:id' do
    recipe = Recipe.find_by(id: params[:id])
    recipe.update(name: params[:name])
    recipe.update(ingredients: params[:ingredients])
    recipe.update(cook_time: params[:cook_time])
    redirect("recipes/#{recipe.id}")
  end


end
