require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/ships'
require './lib/space'
require './lib/validate'
require 'pry'

class ValidateTest <Minitest::Test

  def test_it_exists
    v = Validate.new

    assert_instance_of Validate, v
  end

  def test_it_can_hit_or_miss
    v = Validate.new
    b = Board.new
    user_input_1 = "A1 A2"
    user_input_2 = "A1"
    user_input_3 = "B1 D2"
    user_input_4 = "B2 C2"

    assert v.validate_destroyer_placement(user_input_1,b.grid)
    refute v.validate_destroyer_placement(user_input_2,b.grid)
    refute v.validate_destroyer_placement(user_input_3,b.grid)
    assert v.validate_destroyer_placement(user_input_4,b.grid)

  end
end
