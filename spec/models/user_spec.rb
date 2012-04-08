require 'spec_helper'

class UserSpec
  describe User do
    describe "#movies_unrated_among" do
      before(:each) do
        @dinosaur_planet = Factory.create(:movie_dinosaur_planet)
        @congo = Factory.create(:movie_congo)
        @batman_begins = Factory.create(:movie_batman_begins)
        @screamers = Factory.create(:movie_screamers)
        @raging_bull = Factory.create(:movie_raging_bull)
      end

      it "should return movies unrated by user" do
        rating_1 = Factory.create(:rating, :value => 3, :movie => @screamers)
        rating_2 = Factory.create(:rating, :value => 4, :movie => @raging_bull)
        rating_3 = Factory.create(:rating, :value => 2, :movie => @dinosaur_planet)
        rating_4 = Factory.create(:rating, :value => 4, :movie => @congo)
        rating_5 = Factory.create(:rating, :value => 4, :movie => @batman_begins)
        rating_6 = Factory.create(:rating, :value => 4, :movie => @screamers)

        user_ratings = [rating_1, rating_2]
        ratings = [rating_3, rating_4, rating_5, rating_6]
        user = Factory.create(:user, :ratings => user_ratings)
        unrated = user.unrated_among(ratings)
        unrated.size.should eq(3)
        unrated.detect{|r| r.movie == @dinosaur_planet}.should_not be_nil
        unrated.detect{|r| r.movie == @congo}.should_not be_nil
        unrated.detect{|r| r.movie == @batman_begins}.should_not be_nil
      end

      it "should return empty array when all movies have been rated by user" do
        rating_1 = Factory.create(:rating, :value => 3, :movie => @movie_1)
        rating_2 = Factory.create(:rating, :value => 4, :movie => @movie_2)
        rating_3 = Factory.create(:rating, :value => 4, :movie => @movie_1)
        rating_4 = Factory.create(:rating, :value => 4, :movie => @movie_2)

        user_ratings = [rating_1, rating_2]
        ratings = [rating_3, rating_4]
        user = Factory.create(:user, :ratings => ratings)
        unrated = user.unrated_among(ratings)
        unrated.should_not be_nil
        unrated.size.should eq(0)
      end
      end
  end
end
