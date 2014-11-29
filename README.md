### [Launch Academy](http://www.launchacademy.com/) Challenge:

### Instructions

Build a web application using Sinatra to display a list of recipes stored in a PostgreSQL database.

### Requirements

The web application should satisfy the following user stories:

```no-highlight
As a chef
I want to view a list of recipes
So that I may choose one that seems appetizing
```

Acceptance Criteria:

* Visiting `/recipes` lists the names of all of the recipes in the database, sorted alphabetically.
* Each name is a link that takes you to the recipe details page (e.g. `/recipes/1`)

```no-highlight
As a chef
I want to view the details for a single recipe
So that I can learn how to prepare it
```

Acceptance Criteria:

* Visiting `/recipes/:id` will show the details for a recipe with the given ID.
* The page must include the recipe name, description, and instructions.
* The page must list the ingredients required for the recipe.
