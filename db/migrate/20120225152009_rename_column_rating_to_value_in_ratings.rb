class RenameColumnRatingToValueInRatings < ActiveRecord::Migration
  def change
    rename_column :ratings, :rating, :value
  end
end
