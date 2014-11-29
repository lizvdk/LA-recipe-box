require 'sinatra'
require 'sinatra/reloader'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')
    yield(connection)
  ensure
    connection.close
  end
end

get '/recipes' do
  #lists the names of all the recipes in the database, sorted a-z
  #each recipe name links to the recipes details page
  erb :'recipes/index'
end

get '/recipes/:id'
  #show the details for a recipe with the given ID.
  #includes recipe name, description, and instructions.
  #lists the ingredients required for the recipe.
  erb :'recipes/info'
end
