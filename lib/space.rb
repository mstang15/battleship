
class Space
attr_reader :empty,
            :hit,
            :ship_present,
            :peg,
            :square_display,
            :sunk

  def initialize
    @empty = true
    @hit = false
    @ship_present = false
    @sunk = false
  end

  def ship_placed
    @empty = false
    @ship_present = true
  end

  def guess
    @hit = true
  end

  def square_display
    if @empty == true && @hit == false
      print " ."
    elsif @sunk == true
      print " S"
    elsif @empty == true && @hit == true
      print " M"
    elsif @ship_present && @hit == true
      print " H"
    elsif @ship_present && @hit == false
      print ' .'
    end
  end

  def sink
    @sunk = true
  end

end
