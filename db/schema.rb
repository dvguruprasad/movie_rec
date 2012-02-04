# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120204143520) do

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.string   "director"
    t.integer  "runtime"
    t.string   "plot"
    t.string   "imdb_rated"
    t.integer  "imdb_rating"
    t.string   "poster"
    t.string   "actors"
    t.string   "writer"
    t.integer  "imdb_votes"
    t.date     "released"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["movie_id"], :name => "fk_ratings_movies"
  add_index "ratings", ["user_id"], :name => "fk_ratings_users"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
