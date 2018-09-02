require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship'
require './lib/board'
require './lib/ships'
require './lib/space'
require 'pry'

class ComputerTest < Minitest::Test

  def test_it_exists
    s = Ships.new

    assert_instance_of Ships, s
  end

  def test_it_can_place_destroyer
    s = Ships.new
    b = Board.new
    expected = []
    assert_equal expected, s.computer_place_destroyer(b.grid)
  end

end
