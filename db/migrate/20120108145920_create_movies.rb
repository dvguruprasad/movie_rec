class CreateMovies < ActiveRecord::Migration
  def change
    create_table(:movies) do |t|
      t.string :title
      t.string :director
      t.integer :runtime
      t.string :plot
      t.string :imdb_rated
      t.integer :imdb_rating
      t.string :poster
      t.string :actors
      t.string :writer
      t.integer :imdb_votes
      t.date :released
      t.timestamps
    end
  end
end
