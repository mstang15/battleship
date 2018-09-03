require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/ships'
require './lib/space'
require 'pry'

class ValidateTest <Minitest::Test

  def test_it_exists
    v = Validate.new

    assert_instance_of Validate, v
  end

  def test_it_can_hit_or_miss
    v = Validate.new
    b = Board.new
    b.grid["A"][2].guess
    user_input = "A3"

    assert_equal " M", v.hit_or_miss(user_input,b.grid)
  end
end
