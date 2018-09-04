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

  def test_it_can_be_horizontal_or_vertical
    s = Ships.new

    assert_instance_of String, s.horizontal_or_vertical
  end

  def test_horizontal_placement_destroyer_returns_array
    s = Ships.new
    b = Board.new

    assert_instance_of Array, s.horizontal_placement_destroyer(b.grid)
  end

  def test_horizontal_placement_destroyer_returns_array_with_length_2
    s = Ships.new
    b = Board.new

    assert_equal 2, s.horizontal_placement_destroyer(b.grid).length
  end

  def test_vertical_placement_destroyer_returns_array
    s = Ships.new
    b = Board.new

    assert_instance_of Array, s.vertical_placement_destroyer(b.grid)
  end

  def test_vertical_placement_destroyer_returns_array_with_length_2
    s = Ships.new
    b = Board.new

    assert_equal 2, s.vertical_placement_destroyer(b.grid).length
  end

  def test_horizontal_placement_cruiser_returns_array
    s = Ships.new
    b = Board.new

    assert_instance_of Array, s.horizontal_placement_cruiser(b.grid)
  end

  def test_horizontal_placement_cruiser_returns_array_with_length_3
    s = Ships.new
    b = Board.new

    assert_equal 3, s.horizontal_placement_cruiser(b.grid).length
  end

  def test_vertical_placement_cruiser_returns_array
    s = Ships.new
    b = Board.new

    assert_instance_of Array, s.vertical_placement_cruiser(b.grid)
  end

  def test_vertical_placement_cruiser_returns_array_with_length_3
    s = Ships.new
    b = Board.new

    assert_equal 3, s.vertical_placement_cruiser(b.grid).length
  end

  def test_it_can_create_random_guess
    s = Ships.new
    guess = s.generate_random_guess

    assert_equal 2, guess.length
  end

  def test_it_can_record_new_guess
    s = Ships.new
    guess_1 = s.generate_random_guess
    guess_2 = s.generate_random_guess

    assert_equal 2, s.computer_guesses.length
  end

end
