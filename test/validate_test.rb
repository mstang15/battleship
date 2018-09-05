require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ships'
require './lib/space'
require './lib/validate'


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


  
end
