class Movie < ActiveRecord::Base
  def self.create_from(values, id)
    movies_not_found_in_ml_data = []
    movie = Movie.new do |m|
      m.director = values[0]
      m.runtime = values[1]
      m.plot = values[2]
      m.title = values[3]
      m.imdb_rated = values[7]
      m.imdb_rating = values[8]
      m.poster = values[9]
      m.actors = values[10]
      m.writer = values[11]
      m.imdb_votes = values[12]
      m.released = values[13]
      m.id = id if id
      m.save
    end
  end
end
