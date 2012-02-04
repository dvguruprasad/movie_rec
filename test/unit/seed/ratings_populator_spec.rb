require 'seed/ratings_populator'

class RatingsPopulatorSpec
  describe RatingsPopulator do 
    it "should populate ratings" do
      p = RatingsPopulator.new("ratings_file")
      IO.stub(:read).with("ratings_file").and_returns(ratings_data)
      Movie.expects(:exists?).with(1).returns(true)
      User.any_instance.expects(:save)
      Rating.any_instance.expects(:save)
      p.populate
    end

    def ratings_data
      <<-HERE
         1::Toy Story (1995)::Adventure|Animation|Children|Comedy|Fantasy
      HERE
    end
  end
end
