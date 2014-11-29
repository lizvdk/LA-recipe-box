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
  query=
    "SELECT
      recipes.name as recipe_name,
      recipes.id as recipe_id
    FROM
      recipes
    ORDER BY
      recipe_name;"
  @recipes = db_connection{|db| db.exec(query)}

  erb :'recipes/index'
end

get '/recipes/:id' do
  id = params['id']
  info_query=
    "SELECT
      recipes.name as recipe_name,
      recipes.id as recipe_id,
      recipes.description as description,
      recipes.instructions as instructions
    FROM
      recipes
    WHERE
      recipes.id = $1"

  ingredient_query=
    'SELECT
      recipes.id as recipe_id,
      ingredients.name as ingredient
    FROM
      ingredients
    JOIN
      recipes
    ON
      ingredients.recipe_id = recipes.id
    WHERE recipes.id = $1;'
  @recipe_info = db_connection{|db| db.exec(info_query, [id])}.first
  @ingredients = db_connection{|db| db.exec(ingredient_query, [id])}

  @recipe_name = @recipe_info['recipe_name']
  @recipe_desription = @recipe_info['description']
  @recipe_instructions = @recipe_info['instructions']

  #lists the ingredients required for the recipe.
  erb :'recipes/info'
end
