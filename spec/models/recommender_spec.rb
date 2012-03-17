require 'spec_helper'

class RecommenderSpec
  describe Recommender do
    describe ".recommend" do
      context "when using similarity to recommend movies" do
        it "recommends all movies rated by a user if only one similar user is found" do
          user = User.new(:name => "user")
          ratings = [Rating.new(:value => 4, :movie => Movie.new(:id => 1)), Rating.new(:value => 3, :movie => Movie.new(:id => 2))]
          similar_users = [user("similar user", ratings)]
          Similarity.should_receive(:similar_to).with(user).and_return(similar_users)
          movies_recommended = Recommender.recommend(user)
          movies_recommended.should have(2).items
        end
      end

      def user(name, ratings)
        User.new(:name => name, :ratings => ratings)
      end
    end
  end
  
end

class Similarity

end
