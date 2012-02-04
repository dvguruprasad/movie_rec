# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'seed/movies_populator'
require 'seed/ratings_populator'

if(ENV["MOVIES_FROM_IMDB"] && ENV["MOVIES_FROM_ML"])
  MoviesPopulator.new(ENV["MOVIES_FROM_IMDB"]).populate
  RatingsPopulator.new(ENV["RATINGS_FROM_ML"]).populate
else
  p "ERROR: Seeding did not occur"
  p "Usage: MOVIES_FROM_IMDB=[imdb_movies_file_location] MOVIES_FROM_ML=[ml_movies_file_location] RATINGS_FROM_ML=[ml_ratings_file_location] rake db:seed"
end
