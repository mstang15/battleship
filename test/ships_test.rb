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

  # def test_it_can_choose_horizontal_or_vertical
  #   s = Ships.new
  #
  #   assert_ "horizontal", s.horizontal_or_vertical
  #   assert_equal "vertical", s.horizontal_or_vertical
  # end

  def test_it_can_create_random_coordinate
    s = Ships.new
    guess = s.generate_random_guess

    assert_equal 2, guess.length
  end

  # def test_it_can_place_horizontal_destroyer
  #   s = Ships.new
  #   b = Board.new
  #
  #   assert_equal ["A","B","C","D"], b.grid.keys
  # end

  def test_it_can_record_new_guess
    s = Ships.new
    guess_1 = s.generate_random_guess
    guess_2 = s.generate_random_guess

    assert_equal 2, s.computer_guesses.length
  end

end
