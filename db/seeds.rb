# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def split_respecting_double_quotes(str, delim)
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

def create_movie(values)
  movie = Movie.new do |m|
    m.director = values[0]
    m.runtime = runtime_in_mins(values[1])
    m.plot = values[2]
    m.title = values[3]
    m.imdb_rated = values[7]
    m.imdb_rating = values[8]
    m.poster = values[9]
    m.actors = values[10]
    m.writer = values[11]
    m.imdb_votes = values[12]
    m.released = parse_released_date(values[13])
    m.save
  end
end

def seed_data
  lines = IO.read(ENV["MOVIES_FROM_IMDB"], :encoding => "UTF-8").split("\n")
  lines.delete_at(0)
  lines.each do |line|
    values = split_respecting_double_quotes(line, ',')
    create_movie(values)
  end
end

if(ENV["MOVIES_FROM_IMDB"])
  seed_data
else
  p "ERROR: Seeding did not occur since imdb movies file location was not passed."
  p "Usage: MOVIES_FROM_IMDB=[imdb_movies_file_location] rake db:seed"
end

