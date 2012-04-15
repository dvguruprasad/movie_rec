Factory.define :user do |user|
  user.name 'ninja'
  user.email 'ninja@foo.com'
end

Factory.define :movie do |movie|
  movie.ratings {|m| m.association(:rating)}
end

Factory.define :rating do |rating|
  rating.movie {|r| r.association(:movie)}
end

Factory.define :movie_dinosaur_planet, :class => Movie do |movie|
  movie.title "Dinosaur Planet" 
end

Factory.define :movie_congo, :class => Movie do |movie|
  movie.title "Congo" 
end

Factory.define :movie_batman_begins, :class => Movie do |movie|
  movie.title "Batman Begins" 
end

Factory.define :movie_screamers, :class => Movie do |movie|
  movie.title "Screamers" 
end

Factory.define :movie_raging_bull, :class => Movie do |movie|
  movie.title "Raging Bull" 
end

Factory.define :movie_fight_club, :class => Movie do |movie|
  movie.title "Fight Club"
end
