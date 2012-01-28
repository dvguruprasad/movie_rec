class MovieLens
  def self.id_from_title(title)
    movies = {}
    File.open(ENV["MOVIES_FROM_ML"]).lines.each do |l|
      values = l.split('::')
      movie_title = values[1].sub(/\s\(\d+\)/,"")
      movies[movie_title] = values[0]
    end
    movies[title]
  end
end
