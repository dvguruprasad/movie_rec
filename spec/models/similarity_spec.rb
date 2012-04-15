require 'spec_helper'

class SimilaritySpec
  describe Similarity do
    describe ".pearson_similarity_score" do 
      before(:each) do
        @congo = Factory.create(:movie_congo)
        @dinosaur_planet = Factory.create(:movie_dinosaur_planet)
        @batman_begins = Factory.create(:movie_batman_begins)
        @screamers = Factory.create(:movie_screamers)
        @raging_bull = Factory.create(:movie_raging_bull)
        @fight_club = Factory.create(:movie_fight_club)
      end

      it "should find similarity score for two users" do
        sherlock_ratings = [rating(2.5, @congo), rating(3.5, @dinosaur_planet), rating(3.0, @batman_begins), 
                              rating(3.5, @screamers), rating(2.5, @raging_bull), rating(3.0, @fight_club)]
        john_ratings = [rating(3.0, @congo), rating(3.5, @dinosaur_planet), rating(1.5, @batman_begins), 
                          rating(5.0, @screamers), rating(3.5, @raging_bull), rating(3.0, @fight_club)]
        sherlock = User.new(:name => "Sherlock", :ratings => sherlock_ratings)
        john = User.new(:name => "John", :ratings => john_ratings)

        score = Similarity.send(:pearson_similarity_score, sherlock, john)
        score.should eq(0.39605901719066977)
      end

      def rating(value, movie) 
        Rating.new(:value => value, :movie => movie)
      end
    end
  end
end
