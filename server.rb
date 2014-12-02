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

def recipe_name_id
  query =
    "SELECT
      recipes.name as recipe_name,
      recipes.id as recipe_id
    FROM
      recipes
    ORDER BY
      recipe_name;"
  db_connection{|db| db.exec(query)}
end

indiv_recipe_info =
    "SELECT
      recipes.name as recipe_name,
      recipes.id as recipe_id,
      recipes.description as description,
      recipes.instructions as instructions,
      ingredients.name as ingredient
    FROM
      recipes
    JOIN
      ingredients
    ON
      ingredients.recipe_id = recipes.id
    WHERE
      recipes.id = $1"

get '/' do
  redirect '/recipes'
end

get '/recipes' do

  @recipes = recipe_name_id

  erb :'recipes/index'
end

get '/recipes/:id' do
  id = params['id']
  @recipe_info = db_connection{|db| db.exec(indiv_recipe_info, [id])}

  @recipe_name = @recipe_info.first['recipe_name']
  @recipe_desription = @recipe_info.first['description']
  @recipe_instructions = @recipe_info.first['instructions']

  erb :'recipes/info'
end
