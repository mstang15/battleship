require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
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

  def test_computer_place_destroyer_returns_array
    s = Ships.new
    b = Board.new

    assert_instance_of Array, s.computer_place_destroyer(b.grid)
  end

  def test_computer_place_cruiser_returns_array
    s = Ships.new
    b = Board.new

    assert_instance_of Array, s.computer_place_cruiser(b.grid)
  end

  def test_it_can_create_random_guess
    s = Ships.new
    guess = s.generate_random_guess

    assert_equal 2, guess.length
  end

  def test_it_can_record_new_guess
    s = Ships.new
    s.generate_random_guess
    s.generate_random_guess

    assert_equal 2, s.computer_guesses.length
  end

  def test_it_can_make_array_of_horizontal_destroyer
    s = Ships.new

    assert_equal ["A1","A2"], s.horizontal_ship_array("A","01")
  end

  def test_it_can_make_array_of_horizontal_cruiser
    s = Ships.new

    assert_equal ["D1", "D2","D3"], s.horizontal_ship_array("D","012")
  end

  def test_it_can_make_array_of_vertical_destroyer
    s = Ships.new

    assert_equal ["B1","C1"], s.vertical_ship_array("BC",0)
  end

  def test_it_can_make_array_of_vertical_cruiser
    s = Ships.new

    assert_equal ["A4","B4","C4"], s.vertical_ship_array("ABC",3)
  end

  def test_it_can_place_ships_when_vertical_placement
    s = Ships.new
    b = Board.new
    k_1 = "ABC"
    k_2 = "BCD"
    i_1 = 3
    i_2 = 1
    grid = b.grid
    s.ship_placed_on_vertical_ship(k_1, i_1, grid)
    s.ship_placed_on_vertical_ship(k_2, i_2, grid)

    assert grid["A"][3].ship_placed
    assert grid["B"][3].ship_placed
    assert grid["C"][3].ship_placed
    refute grid["A"][3].empty
    refute grid["B"][3].empty
    refute grid["C"][3].empty
    assert grid["B"][1].ship_placed
    assert grid["C"][1].ship_placed
    assert grid["D"][1].ship_placed
    refute grid["B"][1].empty
    refute grid["C"][1].empty
    refute grid["D"][1].empty
  end

  def test_it_can_place_ship_when_horizontal_placement
    s = Ships.new
    b = Board.new
    k_1 = "A"
    k_2 = "C"
    i_1 = "012"
    i_2 = "123"
    grid = b.grid

    s.ship_placed_on_horizontal_ship(k_1, i_1, grid)
    s.ship_placed_on_horizontal_ship(k_2, i_2, grid)

    assert grid["A"][0].ship_placed
    assert grid["A"][1].ship_placed
    assert grid["A"][2].ship_placed
    refute grid["C"][1].empty
    refute grid["C"][2].empty
    refute grid["C"][3].empty
    assert grid["A"][0].ship_placed
    assert grid["A"][1].ship_placed
    assert grid["A"][2].ship_placed
    refute grid["C"][1].empty
    refute grid["C"][2].empty
    refute grid["C"][3].empty
  end

  def test_horizontal_ship_array_returns_coordinates_plus_1
    s = Ships.new
    b = Board.new
    k_1 = "A"
    k_2 = "C"
    i_1 = "012"
    i_2 = "123"
    grid = b.grid

    assert_equal ["A1","A2","A3"], s.ship_placed_on_horizontal_ship(k_1,i_1,grid)
    assert_equal ["C2","C3","C4"], s.ship_placed_on_horizontal_ship(k_2,i_2,grid)
  end

  def test_vertical_ship_array_returns_coordinates_plus_1
    s = Ships.new
    b = Board.new
    k_1 = "ABC"
    k_2 = "BCD"
    i_1 = 3
    i_2 = 1
    grid = b.grid

    assert_equal ["A4","B4","C4"],s.ship_placed_on_vertical_ship(k_1, i_1, grid)
    assert_equal ["B2","C2","D2"],s.ship_placed_on_vertical_ship(k_2, i_2, grid)
  end
end
