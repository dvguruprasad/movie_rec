class User < ActiveRecord::Base
  has_many :ratings
  
  def unrated_among(other_ratings)
    other_ratings.reject{|r| has_rated(r.movie_id)}
  end

  private 
  def has_rated(movie_id)
    !!ratings.detect{|r| r.movie_id == movie_id}
  end
end
