class CreateRatings < ActiveRecord::Migration
  def up
    create_table :ratings do |t|
      t.integer :rating
      t.references :user
      t.references :movie
      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE ratings
        ADD CONSTRAINT fk_ratings_users FOREIGN KEY (user_id) REFERENCES users(id),
        ADD CONSTRAINT fk_ratings_movies FOREIGN KEY (movie_id) REFERENCES movies(id)
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE ratings DROP CONSTRAINT fk_ratings_users
      ALTER TABLE ratings DROP CONSTRAINT fk_ratings_movies
    SQL
  end
end
