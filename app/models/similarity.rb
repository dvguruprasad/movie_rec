class Similarity
  def self.similar_to(user)
  end

  private
  def self.pearson_similarity_score(user1, user2)
    common_movies = user1.common_movies_rated(user2)
    return 0 if common_movies.empty?
    n = common_movies.size
    ratings1 = {}
    ratings2 = {}

    user1.ratings.map{|r| ratings1[r.movie_id] = r.value}
    user2.ratings.map{|r| ratings2[r.movie_id] = r.value}

    sum1 = common_movies.inject(0.0){|sum, m| sum += ratings1[m.id]}
    sum2 = common_movies.inject(0.0){|sum, m| sum += ratings2[m.id]}

    sum_sq1 = common_movies.inject(0.0){|sum, m| sum += (ratings1[m.id] ** 2)}
    sum_sq2 = common_movies.inject(0.0){|sum, m| sum += (ratings2[m.id] ** 2)}

    sum_of_products = common_movies.inject(0){|sum, m| sum += (ratings1[m.id] * ratings2[m.id])}
    num = sum_of_products - (sum1 * sum2) / n
    den = Math.sqrt(((sum_sq1 - ((sum1 ** 2) / n)) * (sum_sq2 - ((sum2 ** 2) / n))).abs)
    return 0 if den == 0
    num/den
  end
end
