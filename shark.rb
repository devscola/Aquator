class Shark 
  def initialize(position)
    @position = position
    @generator = RandomGenerator
    @energy = 3
  end

  def act (fishes,unoccupied)
    @energy -= 1
    if (fishes.empty?) 
      move(unoccupied)
    else
      eat(fishes)
    end    
  end

  def eat fishes
    move(fishes)
    @energy +=2
  end

  def where
    @position
  end

  def energy_left
    @energy
  end

  def move(allowed_positions) 
    return if allowed_positions.empty?
    random = @generator.random(allowed_positions.size)
    @position = allowed_positions[random]
  end

  def dead?
    return (energy_left == 0)
  end

  class RandomGenerator
    def self.random limit
      rand(limit)
    end
  end
end