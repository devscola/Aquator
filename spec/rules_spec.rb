require "./fish"

describe "Aquator Rules" do
  
  describe "for the fish" do

    before :each do
      @a_fish= TestFish.new(:initial_position) 
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

    it 'may not reproduce' do
      a_chronon_passes

      child = @a_fish.child

      expect(child).to be_nil
    end

    describe 'when certain number of chronons passes' do
      before(:each) { time_to_reproduce_arrives }

      it 'reproduces when moves' do
        parent_last_position = register_position_and_move
        child = @a_fish.child

        expect(child).to be_a(Fish)
        expect(child.where).to be(parent_last_position)
        expect(@a_fish.where).to_not be(parent_last_position)
      end
    end

    def register_position_and_move
      parent_last_position = @a_fish.where
      @adjacent_unoccupied_squares.delete(parent_last_position)
      a_chronon_passes

      parent_last_position
    end

    def a_chronon_passes 
      @a_fish.act(@adjacent_unoccupied_squares)
    end

    def time_to_reproduce_arrives
      3.times { a_chronon_passes }
    end

    def current_position
      @a_fish.where
    end
  end

  class TestFish < Fish
    def child
      @child
    end
  end
end
