require "./fish"
require "./shark"

class TestFish < Fish
  def child
    @children.last
  end

  def how_many_children
    @children.size
  end
end

describe "Aquator Rules" do
  
  describe "for the fish" do
    let(:unoccupied) {[:here,:there]}
    
    before :each do
      @a_fish= TestFish.new(:initial_position) 
    end

    it "At each chronon,a fish moves" do
      last_position = current_position
      @a_fish.act(unoccupied)

      expect(current_position).to_not be nil
      expect(current_position).to_not be last_position
    end


    it "moves randomly to one of the adjacent unoccupied squares" do
      @a_fish.act(unoccupied)
      
      expect(unoccupied).to include(current_position)
    end

    it 'If there are no free squares, no movement takes place.' do
      last_position=current_position
      @a_fish.act([])
      expect(current_position).to be last_position
    end

    it 'may not reproduce' do
      @a_fish.act(unoccupied)

      child = @a_fish.child

      expect(child).to be_nil
    end

    describe 'when reproduction span passes' do
      before(:each) { time_to_reproduce_arrives }

      it 'reproduces when moves' do
        
        parent_last_position = @a_fish.where
        unoccupied.delete(parent_last_position)
        
        @a_fish.act(unoccupied)
        child = @a_fish.child

        expect(child).to be_a(Fish)
        expect(child.where).to be(parent_last_position)
        expect(@a_fish.where).to_not be(parent_last_position)
      end

      it 'reproduces every reproduction span' do
        @a_fish.act(unoccupied)
        time_to_reproduce_arrives
        @a_fish.act(unoccupied)
        children = @a_fish.how_many_children
        expect(children).to eq 2
      end

    end

    def register_position_and_move
      parent_last_position = @a_fish.where
      unoccupied.delete(parent_last_position)
      @a_fish.act(unoccupied)

      parent_last_position
    end


    def time_to_reproduce_arrives
      3.times { @a_fish.act(unoccupied) }
    end

    def current_position
      @a_fish.where
    end
  end

  describe 'for the shark' do

    before :each do
      @a_shark= Shark.new(:initial_position)  
    end

    it 'At each chronon, a shark moves randomly to an adjacent square occupied by a fish' do
      adjacent_fishes_positions = [:here, :there]
      @a_shark.act(adjacent_fishes_positions,[])
      expect(adjacent_fishes_positions).to include @a_shark.where
    end

    it 'If no fishes, the shark moves to a random adjacent unoccupied square' do
      adjacent_fishes_positions = []
      adjacent_unoccupied_squares=[:here, :there]
      @a_shark.act(adjacent_fishes_positions,adjacent_unoccupied_squares)
      expect(adjacent_unoccupied_squares).to include @a_shark.where     
    end

    it 'If there are no free squares, no movement takes place' do
      @a_shark.act([],[])
      expect(@a_shark.where).to be :initial_position    
    end

    it 'At each chronon, each shark is deprived of a unit of energy.' do
      initial=@a_shark.energy_left
      @a_shark.act([],[])
      expected=initial-1
      expect(@a_shark.energy_left).to eq expected
    end

    it 'dies when energy reaches zero' do
      initial_energy=3
      was_dead= @a_shark.dead?
      
      initial_energy.times{@a_shark.act([],[])}
      
      expect(was_dead).to be false
      expect(@a_shark.dead?).to be true
    end

    it 'If a shark moves to a square occupied by a fish, it eats the fish and earns a certain amount of energy.' do
      initial=@a_shark.energy_left
      adjacent_fishes_positions = [:here, :there]
      @a_shark.act(adjacent_fishes_positions,[])
      expect(@a_shark.energy_left).to eq initial + 1
    end
  end

end
