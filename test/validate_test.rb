require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
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

  def test_it_can_store_computer_ships
    v = Validate.new

    destroyer = ["A1","A2"]
    cruiser = ["B1","C1","D1"]
    v.store_computer_ships(destroyer,cruiser)

    assert_equal 2, v.computer_destroyer.length
    assert_equal 3, v.computer_cruiser.length
  end

  def test_it_can_store_player_ships
    v = Validate.new

    destroyer = ["A1","A2"]
    cruiser = ["B1","C1","D1"]
    v.store_player_ships(destroyer,cruiser)

    assert_equal 2, v.player_destroyer.length
    assert_equal 3, v.player_cruiser.length
  end

  def test_it_can_store_player_guesses
    v = Validate.new
    b = Board.new

    v.store_player_guesses("A1", b.grid)
    v.store_player_guesses("B4", b.grid)

    assert_equal ["A1","B4"], v.player_guesses
  end

  def test_it_can_store_computer_guesses
    v = Validate.new
    b = Board.new

    v.store_computer_guesses("A1", b.grid)
    v.store_computer_guesses("B4", b.grid)

    assert_equal ["A1","B4"], v.computer_guesses
  end

  def test_it_can_hit_or_miss
    v = Validate.new
    b = Board.new
    user_input_1 = "A1 A2"
    user_input_2 = "A1"
    user_input_3 = "B1 D2"
    user_input_4 = "B2 C2"

    assert v.validate_destroyer_placement(user_input_1)
    refute v.validate_destroyer_placement(user_input_2)
    refute v.validate_destroyer_placement(user_input_3)
    assert v.validate_destroyer_placement(user_input_4)

  end

  def test_it_can_sink_ships
    v = Validate.new
    b = Board.new
    grid = b.grid
    ship_1 = ["A1", "A2"]
    ship_2 = ["A1", "A2", "A3"]
    v.sunk(ship_1,grid)
    v.sunk(ship_2,grid)

    assert grid[ship_1[0][0]][ship_1[0][-1].to_i-1].sunk
    assert grid[ship_1[1][0]][ship_1[1][-1].to_i-1].sunk
    assert grid[ship_2[0][0]][(ship_2[0][-1].to_i)-1].sink
    assert grid[ship_2[1][0]][(ship_2[1][-1].to_i)-1].sink
    assert grid[ship_2[2][0]][(ship_2[2][-1].to_i)-1].sink
  end

  def test_hit_guess_makes_spot_not_empty
    v = Validate.new
    b = Board.new
    grid = b.grid
    v.hit_guess("A1",grid)

    assert grid["A"][0].empty
    assert grid["A"][0].hit
  end

  def test_validate_guess
    v = Validate.new
    guess_1 = "A"
    guess_2 = "A@"
    guess_3 = "B1 B2"
    guess_4 = "C6"
    guess_5 = "E1"
    guess_6 = "B2"

    refute v.validate_guess(guess_1)
    refute v.validate_guess(guess_2)
    refute v.validate_guess(guess_3)
    refute v.validate_guess(guess_4)
    refute v.validate_guess(guess_5)
    assert v.validate_guess(guess_6)
  end

  def test_destroyer_placement
    v = Validate.new
    p1 = "A"
    p2 = "A1"
    p3 = "A1 A"
    p4 = "B6 B2"
    p5 = "B1 D2"
    p6 = "B# D1"
    p7 = "C4 B4"
    p8 = "D2 D3"
    p9 = "A1 A2 A3"

    refute v.validate_destroyer_placement(p1)
    refute v.validate_destroyer_placement(p2)
    refute v.validate_destroyer_placement(p3)
    refute v.validate_destroyer_placement(p4)
    refute v.validate_destroyer_placement(p5)
    refute v.validate_destroyer_placement(p6)
    assert v.validate_destroyer_placement(p7)
    assert v.validate_destroyer_placement(p8)
    refute v.validate_destroyer_placement(p9)
  end


  def test_cruiser_placement
    v = Validate.new
    b = Board.new
    p1 = "A"
    p2 = "A1"
    p3 = "A1 A"
    p4 = "B6 B2"
    p5 = "B1 D2"
    p6 = "B# D1"
    p7 = "C4 B4"
    p8 = "D2 D3"
    p9 = "A1 A1"
    p10 = "A1 A2 A3"
    p11 = "A1 A3"
    p12 = "B1 D1"
    p13 = "D4 B4"
    p13 = "C3 C1"
    grid = b.grid

    refute v.validate_cruiser_placement(p1,grid)
    refute v.validate_cruiser_placement(p2,grid)
    refute v.validate_cruiser_placement(p3,grid)
    refute v.validate_cruiser_placement(p4,grid)
    refute v.validate_cruiser_placement(p5,grid)
    refute v.validate_cruiser_placement(p6,grid)
    refute v.validate_cruiser_placement(p7,grid)
    refute v.validate_cruiser_placement(p8,grid)
    refute v.validate_cruiser_placement(p9,grid)
    refute v.validate_cruiser_placement(p10,grid)
    assert v.validate_cruiser_placement(p11,grid)
    assert v.validate_cruiser_placement(p12,grid)
    assert v.validate_cruiser_placement(p13,grid)
  end


end
