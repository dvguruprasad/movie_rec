Factory.define :user do |user|
  user.name 'ninja'
  user.email 'ninja@foo.com'
end

Factory.define :rating do |rating|
end

Factory.define :movie do |movie|
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
