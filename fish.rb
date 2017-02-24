class Fish
  
  def initialize(position ,generator=RandomGenerator)
    @position= position
    @generator= generator
  end

  def move(allowed_positions)
    return if allowed_positions.empty?
    random=@generator.random(allowed_positions.size)
    @position = allowed_positions[random]
  end
  
  def where
    @position
  end

  class RandomGenerator
    def self.random limit
      rand(limit)
    end
  end

end