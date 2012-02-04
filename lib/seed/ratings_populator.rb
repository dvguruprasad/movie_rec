class RatingsPopulator
  def initialize(ml_ratings_file)
    @ml_ratings_file = ml_ratings_file
  end

  def populate
    lines = IO.read(@ml_ratings_file, :encoding => "UTF-8").split("\n")
    ratings = []
    user_ids = []
    lines.each do |line|
      values = line.split("::")
      if(Movie.exists?(values[1]))
        unless(user_ids.include?(values[0]))
          User.new(){|u| u.id = values[0]; u.save}
          user_ids << values[0]
        end
        Rating.new(:user_id => values[0], :movie_id => values[1], :rating => values[2]).save
      end
    end
  end

  def create_rating(values)
    Rating.new(:user_id => values[0], :movie_id => values[1], :rating => values[2])
  end
end
