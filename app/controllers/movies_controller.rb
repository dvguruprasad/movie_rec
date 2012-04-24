class MoviesController < ApplicationController
  def index
    @movies = Recommender.recommend(User.find(5))
  end
end
