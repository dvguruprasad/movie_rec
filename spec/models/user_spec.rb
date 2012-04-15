require 'spec_helper'

class UserSpec
  describe User do
    before(:each) do
      @dinosaur_planet = Factory.create(:movie_dinosaur_planet)
      @congo = Factory.create(:movie_congo)
      @batman_begins = Factory.create(:movie_batman_begins)
      @screamers = Factory.create(:movie_screamers)
      @raging_bull = Factory.create(:movie_raging_bull)
    end

    describe "#movies_unrated_among" do
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
        rating_1 = Factory.create(:rating, :value => 3, :movie => @raging_bull)
        rating_2 = Factory.create(:rating, :value => 4, :movie => @congo)

        ratings = [rating_1, rating_2]
        user = Factory.create(:user, :ratings => ratings)
        unrated = user.unrated_among(ratings)
        unrated.should_not be_nil
        unrated.size.should eq(0)
      end
    end

    describe "#common_movies_rated" do
      it "returns empty array when nothing in common" do
        user1 = Factory.create(:user, :ratings => [Factory.create(:rating, :value => 4, :movie => @congo), Factory.create(:rating, :value => 3, :movie => @raging_bull)])
        user2 = Factory.create(:user, :ratings => [Factory.create(:rating, :value => 3, :movie => @batman_begins), Factory.create(:rating, :value => 3, :movie => @screamers)])
        common = user1.common_movies_rated(user2)
        common.should have(0).items
      end

      it "should return common movies rated between this and the user passed in " do
        user1 = Factory.create(:user, :ratings => [Factory.create(:rating, :value => 4, :movie => @congo), Factory.create(:rating, :value => 3, :movie => @raging_bull), Factory.create(:rating, :value => 3, :movie => @screamers)])
        user2 = Factory.create(:user, :ratings => [Factory.create(:rating, :value => 3, :movie => @batman_begins), Factory.create(:rating, :value => 3, :movie => @congo), Factory.create(:rating, :value => 3, :movie => @screamers)])
        common = user1.common_movies_rated(user2)
        common.should have(2).items
        common.first.should be(@congo)
        common.last.should be(@screamers)
      end
    end
  end
end
