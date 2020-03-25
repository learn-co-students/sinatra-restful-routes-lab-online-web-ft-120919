class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
get '/recipes/new' do
  erb :new
end
 
post '/recipes' do
  @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
  redirect to "/recipes/#{@recipe.id}"
end

get '/recipes/:id' do
  @recipe = Recipe.find_by_id(params[:id])
  erb :show
end

get '/recipes/:id/edit' do  #load edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
end

patch '/recipes/:id' do #edit action
  @recipes = Article.find_by_id(params[:id])
  @recipes.name = params[:name]
  @recipes.ingredients = params[:ingredients]
  @recipes.cook_time - params[:cook_time]
  @article.save
  redirect to "/articles/#{@recipe.id}"
end

delete '/recipes/:id' do #delete action
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.delete
  redirect to '/recipes'
end


end