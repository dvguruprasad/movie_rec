class Recommender
  def self.recommend(user)
    Similarity.similar_to(user)
    [Movie.new, Movie.new]
  end
end
