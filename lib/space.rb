
class Space
attr_reader :empty, :hit

  def initialize
    @empty = true
    @hit = false
  end

  def ship_placed
    @empty = false
  end

  def guessed_right
    @hit = true
  end

  def boat_placement
    @empty = false 
  end

end
