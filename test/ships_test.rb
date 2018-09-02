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

  def test_it_can_randomly_place_one_peg_of_boat
    s = Ships.new
    b = Board.new
    sp = Space.new

    assert_equal 2, s.initial_random_placement(b.grid).length
  end

  def test_it_can_find_horizontal_placement
    s = Ships.new
    b = Board.new

    assert_equal ["B",2] ,s.horizontal_placement(["B",3])
  end

  def test_it_can_find_vertical_placement
    s = Ships.new
    b = Board.new


    assert_equal ["B",2], s.vertical_placement(["A",2])
  end


end
