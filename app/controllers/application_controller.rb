class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all

    erb :index	 
  end	
  
  get '/recipes/new' do
    erb :new
  end
  
  post '/recipes/new' do
    @recipe = Recipe.new(params[:recipes])
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end
  
  get '/recipes/:id' do
    
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end
  
  get '/recipes/:id/edit' do
    
    # binding.pry
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end
  
  patch '/recipes/:id' do
    recipe = Recipe.find_by_id(params[:id]).tap do |recipe|
      recipe.update(
        name: params[:name],
        ingredients: params[:ingredients],
        cook_time: params[:cook_time]
        )
        
        redirect "/recipes/#{@recipe.id}"
        
      end
    end
    
    delete '/recipes/:id' do
     
      @recipes = Recipe.find_by(params[:id])
      @recipes.destroy
      redirect '/recipes'
    end
  

end
