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
    Recipe.new(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
    ).tap do |recipe|
      recipe.save
      redirect "/recipes/#{recipe.id}"
    end
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    Recipe.find_by(params[:id]).tap do |recipe|
      recipe.update(
        name: params[:name],
        ingredients: params[:ingredients],
        cook_time: params[:cook_time]
      )

      redirect "/recipes/#{recipe.id}"

    end
  end

  delete '/recipes/:id/delete' do
    binding.pry
    Recipe.find_by(params[:id]).destroy
      redirect '/recipes'
    end
  

end
