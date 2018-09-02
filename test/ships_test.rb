require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/ships'
require './lib/space'
require 'pry'

class ComputerTest < Minitest::Test

  def test_it_exists
    s = Ships.new

    assert_instance_of Ships, s
  end

  def test_it_can_place_vertical_destroyer
    s = Ships.new
    b = Board.new

    actual = s.vertical_placement_destroyer(b.grid)
  end

end
