require 'seed/movie_lens'

class MoviesPopulator
  def initialize(imdb_file)
    @imdb_file = imdb_file
  end

  def populate
    lines = IO.read(@imdb_file, :encoding => "UTF-8").split("\n")
    lines.delete_at(0)
    lines.each do |line|
      create_movie(String.split_respecting_double_quotes(line, ','))
    end
  end

  def create_movie(values)
    values[1] = runtime_in_mins(values[1])
    values[13] = parse_released_date(values[13])
    id = MovieLens.id_from_title(values[3])
    Movie.create_from(values, id)
  end

  def runtime_in_mins(str)
    return 0 if str == '' or str == "N/A" or !str
    values = str.split
    return values[0].to_i if values.length == 2
    return values[0].to_i * 60 + values[2].to_i
  end

  def parse_released_date(str)
    return nil if !str || str == "N/A"
    Date.strptime(str, { 1 => "%Y", 2 => "%b %Y", 3 => "%d %b %Y"}[str.split.length])
  end
end


class String
  def self.split_respecting_double_quotes(str, delim)
    result = []
    current_word = ''
    encountered_quotes = false
    str.each_char do |char|
      if(char == "\"" && !encountered_quotes)
        encountered_quotes = true
        next
      end

      if(char == "\"" && encountered_quotes)
        encountered_quotes = false
        next
      end

      if(encountered_quotes)
        current_word << char
        next
      end

      if(char == delim)
        result.push(current_word)
        current_word = ''
      else
        current_word << char
      end
    end
    result.push(current_word) if '' != current_word
    result.collect {|r| r.strip}
  end
end
