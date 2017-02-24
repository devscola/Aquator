require './fish'

describe 'Fish' do

  class RandomStub
    def self.random limit
      0
    end
  end

  it 'moves randomly' do
    a_fish=Fish.new(:position,RandomStub)
    

    a_fish.move([:one,:two,:three])
    expect(a_fish.where).to be :one
  end
  
end