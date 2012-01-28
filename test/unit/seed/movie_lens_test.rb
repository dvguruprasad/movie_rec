require 'seed/movie_lens'

class MovieLensTest
  describe MovieLens do
    it "should get the id given a movie title" do
      file = double("File", :lines => movie_data.split("\n"))
      File.stub(:open).and_return(file)
      MovieLens.id_from_title("Toy Story").should eq("1")
      MovieLens.id_from_title("GoldenEye").should eq("10")
      MovieLens.id_from_title("foobar").should eq(nil)
    end

  def movie_data
    <<HERE
1::Toy Story (1995)::Adventure|Animation|Children|Comedy|Fantasy
2::Jumanji (1995)::Adventure|Children|Fantasy
3::Grumpier Old Men (1995)::Comedy|Romance
4::Waiting to Exhale (1995)::Comedy|Drama|Romance
5::Father of the Bride Part II (1995)::Comedy
6::Heat (1995)::Action|Crime|Thriller
7::Sabrina (1995)::Comedy|Romance
8::Tom and Huck (1995)::Adventure|Children
9::Sudden Death (1995)::Action
10::GoldenEye (1995)::Action|Adventure|Thriller
HERE
  end
  end
end
