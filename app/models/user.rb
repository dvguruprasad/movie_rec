class User < ActiveRecord::Base
  has_many :ratings
  
  def unrated_among(other_ratings)
    other_ratings.reject{|r| has_rated(r.movie_id)}
  end

  def common_movies_rated(another_user)
    result = []
    ratings.each do |r|
      (result << r.movie_id) if another_user.ratings.detect{|au_r| au_r.movie_id == r.movie_id}
    end
    result
  end

  def has_rated(movie_id)
    !!ratings.detect{|r| r.movie_id == movie_id}
  end
end
