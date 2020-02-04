class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # coded actions here!

  get '/recipes' do 
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do 
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/new' do
    # @recipe = Recipe.new
    binding.pry
    erb :new
  end

  # post '/recipes' do 
  #   # @recipe = Recipe.create(params[:name], params[:ingredients], params[:cook_time])
  #   # @recipe = Recipe.create(params)
  #   @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
  #   redirect "/recipes/#{@recipe.id}"
  # end





end

# <form action="/recipes" method="post">
#   <ul>
#     <li>
#       <label for="name">Name</label>
#       <input id="name" type="text" name="name" />
#     </li>
#     <li>
#       <label for="ingredients">Ingredients</label>
#       <textarea id="ingredients" type="text" name="ingredients">
#       </textarea>
#     </li>
#     <li>
#       <label for="cook_time">Cook Time</label>
#       <textarea id="cook_time" type="text" name="cook_time">
#       </textarea>
#     </li>
#   </ul>
#   <input type="submit" />
# </form>