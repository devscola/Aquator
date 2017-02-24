class Fish
  TIME_GRANULARITY = 1
  AGE_OF_REPRODUCTION = 4

  def initialize(position ,generator=RandomGenerator)
    @position= position
    @generator= generator
    @age = 0
  end

  def act(allowed_positions)
    age_increases

    reproduce
    move(allowed_positions)
  end
  
  def where
    @position
  end

  def reproduce
    return unless is_time_to_give_birth?
    @child = Fish.new(@position)
  end

  def move(allowed_positions)
    return if allowed_positions.empty?
    random = @generator.random(allowed_positions.size)
    @position = allowed_positions[random]
  end

  def age_increases
    @age += TIME_GRANULARITY
  end

  def is_time_to_give_birth?
    return (@age == AGE_OF_REPRODUCTION) 
  end

  class RandomGenerator
    def self.random limit
      rand(limit)
    end
  end

end
