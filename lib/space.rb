
class Space
attr_reader :empty, :hit, :ship_present, :peg

  def initialize
    @empty = true
    @hit = false
    @ship_present = false
    
  end

  def ship_placed
    @empty = false
    @ship_present = true
  end

  def guessed_right
    @hit = true
    @peg = red_peg
  end

  def guessed_incorrectly
    @peg = white_peg
  end

  def white_peg
    puts "M"
  end

  def red_peg
    puts "H"
  end



end
