require "./fish"

describe "Aquator Rules" do
  
  describe "for the fish" do

    before :each do
      @a_fish= Fish.new(:initial_position) 
      @adjacent_unoccupied_squares=[:no_occupied, :no_fishes, :nothing]    
    end

    it "At each chronon,a fish moves" do
      last_position = current_position
      a_chronon_passes

      expect(current_position).to_not be nil
      expect(current_position).to_not be last_position
    end


    it "moves randomly to one of the adjacent unoccupied squares" do
      a_chronon_passes
      
      expect(@adjacent_unoccupied_squares).to include(current_position)
    end

    it 'If there are no free squares, no movement takes place.' do
      @adjacent_unoccupied_squares=[]
      last_position=current_position
      a_chronon_passes
      expect(current_position).to be last_position
    end
    
    def a_chronon_passes 
      @a_fish.move(@adjacent_unoccupied_squares)
    end

    def current_position
      @a_fish.where
    end
  end

end