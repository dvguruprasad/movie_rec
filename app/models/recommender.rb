class Recommender
  def self.recommend(user)
    similar_users = Similarity.similar_to(user)

    weighted_rating_sums = weighted_rating_sums(similar_users, user)

    final_movie_ratings = {}
    weighted_rating_sums.each do |movie_id, weighted_rating|
      final_movie_ratings[movie_id] = weighted_rating / similarity_score_sum(similar_users, movie_id)
    end

    result = final_movie_ratings.sort_by{|movie_id, rating| rating}.reverse
    result.collect{|m| Movie.find m.first}
  end

  private
  def self.weighted_rating_sums(similar_users, user)
    weighted_rating_sums = {}
    similar_users.each do |similar_user|
      similar_user[:user].ratings.collect do |rating|
        next if user.has_rated rating.movie_id
        weighted_rating_sums[rating.movie_id] ||= 0
        weighted_rating_sums[rating.movie_id] += rating.value * similar_user[:score]
      end
    end
    weighted_rating_sums
  end

  def self.similarity_score_sum(similar_users, movie_id)
    similar_users.inject(0) do |sum, similar_user|
      sum += (similar_user[:user].has_rated(movie_id)) ? similar_user[:score] : 0
    end
  end
end
