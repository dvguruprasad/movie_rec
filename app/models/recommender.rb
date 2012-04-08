class Recommender
  def self.recommend(user)
    similar_users = Similarity.similar_to(user)
    ratings = similar_users.collect(&:ratings).flatten
    unrated = user.unrated_among(ratings)
    unrated.sort{|a,b| b.value <=> a.value}.collect{|r| Movie.find r.movie_id}
  end
end
