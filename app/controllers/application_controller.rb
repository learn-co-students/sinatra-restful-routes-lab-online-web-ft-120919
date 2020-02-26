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
  
  post '/recipes' do
    @recipe = Recipe.new(params)
    @recipe.save
    # binding.pry
    redirect "/recipes/#{@recipe.id}"
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
      
      # binding.pry
      @recipes = Recipe.find_by_id(params[:id])
      @recipes.destroy
      redirect '/recipes'
    end
    
    
  end
  