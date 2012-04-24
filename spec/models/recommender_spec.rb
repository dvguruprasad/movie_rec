require 'spec_helper'

class RecommenderSpec
  describe Recommender do
    describe ".recommend" do
      context "when using similarity" do
        before(:each) do
          @congo = Factory.create(:movie_congo)
          @dinosaur_planet = Factory.create(:movie_dinosaur_planet)
          @batman_begins = Factory.create(:movie_batman_begins)
          @screamers = Factory.create(:movie_screamers)
          @raging_bull = Factory.create(:movie_raging_bull)
        end

        it "recommends all movies rated by a user if only one similar user is found" do
          user = Factory.create(:user, :name => "user")
          ratings = [Factory.create(:rating, :value => 4, :movie => @dinosaur_planet), Factory.create(:rating, :value => 3, :movie => @congo)]
          similar_users = [{:score => 0.8, :user => Factory.build(:user, :name => "similar_user", :ratings => ratings)}]
          Similarity.should_receive(:similar_to).with(user).and_return(similar_users)
          movies_recommended = Recommender.recommend(user)
          movies_recommended.should have(2).items
          movies_recommended.first.should eq(@dinosaur_planet)
          movies_recommended.last.should eq(@congo)
        end

        it "recommends movies in descending order of their weighted ratings" do
          ratings_user_2 = [Factory.create(:rating, :value => 3, :movie => @congo), 
                              Factory.create(:rating, :value => 4, :movie => @batman_begins), Factory.create(:rating, :value => 2, :movie => @screamers)]
          ratings_user_3 = [Factory.create(:rating, :value => 5, :movie => @raging_bull), Factory.create(:rating, :value => 3, :movie => @dinosaur_planet)]

          user_1 = Factory.create(:user, :name => "user")
          similar_users = [{:score => 0.9, :user => Factory.create(:user, :name => "user_2", :ratings => ratings_user_2)}, 
                          {:score => 0.7, :user => Factory.create(:user, :name => "user_3", :ratings => ratings_user_3)}]
          Similarity.should_receive(:similar_to).with(user_1).and_return(similar_users)
          movies_recommended = Recommender.recommend(user_1)
          movies_recommended.should have(5).items
          movies_recommended[0].should eq(@raging_bull)
          movies_recommended[1].should eq(@batman_begins)
          movies_recommended[2].should eq(@congo)
          movies_recommended[3].should eq(@dinosaur_planet)
          movies_recommended[4].should eq(@screamers)
        end
        
        it "should take every similar user's rating of a movie into account in making recommendations" do
          ratings_user_2 = [Factory.create(:rating, :value => 3, :movie => @congo), 
                              Factory.create(:rating, :value => 2, :movie => @batman_begins), Factory.create(:rating, :value => 2, :movie => @screamers)]
          ratings_user_3 = [Factory.create(:rating, :value => 4, :movie => @congo),
                            Factory.create(:rating, :value => 5, :movie => @batman_begins), Factory.create(:rating, :value => 3, :movie => @dinosaur_planet)]

          user_1 = Factory.create(:user, :name => "user")
          similar_users = [{:score => 0.9, :user => Factory.create(:user, :name => "user_2", :ratings => ratings_user_2)}, 
                          {:score => 0.7, :user => Factory.create(:user, :name => "user_3", :ratings => ratings_user_3)}]
          Similarity.should_receive(:similar_to).with(user_1).and_return(similar_users)
          movies_recommended = Recommender.recommend(user_1)
          movies_recommended.should have(4).items
          movies_recommended[0].should eq(@congo)
          movies_recommended[1].should eq(@batman_begins)
          movies_recommended[2].should eq(@dinosaur_planet)
          movies_recommended[3].should eq(@screamers)
        end

        it "should not recommend movies a user has already rated" do
          ratings_user_1 = [Factory.create(:rating, :value => 4, :movie => @dinosaur_planet)] 
          ratings_user_2 = [Factory.create(:rating, :value => 3, :movie => @congo), Factory.create(:rating, :value => 4, :movie => @batman_begins)]
          ratings_user_3 = [Factory.create(:rating, :value => 3, :movie => @dinosaur_planet), Factory.create(:rating, :value => 2, :movie => @screamers)]

          user = Factory.create(:user, :name => "user", :ratings => ratings_user_1)
          similar_users = [{:score => 0.9, :user => Factory.create(:user, :name => "user_2", :ratings => ratings_user_2)}, 
                           {:score => 0.7, :user => Factory.create(:user, :name => "user_3", :ratings => ratings_user_3)}]
          Similarity.should_receive(:similar_to).with(user).and_return(similar_users)
          movies_recommended = Recommender.recommend(user)
          movies_recommended.should have(3).items
        end
      end
    end
  end
end
