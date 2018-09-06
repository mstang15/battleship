require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ships'
require './lib/space'
require './lib/player'


class PlayerTest <Minitest::Test
  def test_it_exists
    pl = Player.new

    assert_instance_of Player, pl
  end

  def test_space_not_empty_when_destroyer_placed
    pl = Player.new
    b = Board.new

    pl.player_place_destroyer(["A1", "A2"],b.grid)
    pl.player_place_destroyer(["B1", "C1"],b.grid)

    refute b.grid["A"][0].empty
    refute b.grid["A"][1].empty
    refute b.grid["B"][0].empty
    refute b.grid["C"][0].empty
  end

  def test_space_not_empty_not_hit_and_ship_present_when_cruiser_placed
    pl = Player.new
    b = Board.new

    pl.player_place_cruiser(["A1","A3"],b.grid)
    pl.player_place_cruiser(["B1","D1"], b.grid)

    refute b.grid["A"][0].empty
    refute b.grid["A"][1].empty
    refute b.grid["A"][2].empty
    refute b.grid["B"][0].empty
    refute b.grid["C"][0].empty
    refute b.grid["D"][0].empty
    assert b.grid["A"][0].ship_present
    assert b.grid["A"][1].ship_present
    assert b.grid["A"][2].ship_present
    assert b.grid["B"][0].ship_present
    assert b.grid["C"][0].ship_present
    assert b.grid["D"][0].ship_present
    refute b.grid["A"][0].hit
    refute b.grid["A"][1].hit
    refute b.grid["A"][2].hit
    refute b.grid["B"][0].hit
    refute b.grid["C"][0].hit
    refute b.grid["D"][0].hit
  end

  def test_it_can_return_array_of_coordinates
    pl = Player.new
    b = Board.new

    actual_1 = pl.player_place_destroyer(["A1","A2"],b.grid)
    actual_2 = pl.player_place_destroyer(["B1", "C1"],b.grid)

    assert_equal ["A1","A2"], actual_1
    assert_equal ["B1","C1"], actual_2
  end


  def test_interpret_cruiser_coordinates
    pl = Player.new
    b = Board.new

    key_1 = ["A","A"]
    index_1 = [1,3]
    key_2 = ["B","D"]
    index_2 = [1,1]
    key_3 = ["D","B"]
    index_3 = [1,1]


    assert_equal ["A1","A2","A3"], pl.interpret_cruiser_coordinates(key_1,index_1,b.grid)
    assert_equal ["B1","C1","D1"], pl.interpret_cruiser_coordinates(key_2,index_2,b.grid)
    assert_equal ["D1","C1","B1"], pl.interpret_cruiser_coordinates(key_3,index_3,b.grid)
  end

  def test_player_place_cruiser_returns_array
    pl = Player.new
    b = Board.new


    assert_equal ["A1","A2","A3"], pl.player_place_cruiser(["A1","A3"],b.grid)
    assert_equal ["B1","C1","D1"], pl.player_place_cruiser(["B1", "D1"],b.grid)
    assert_equal ["D1","C1","B1"], pl.player_place_cruiser(["D1", "B1"],b.grid)
  end

  def test_it_can_interpret_array_when_same_letter
    pl = Player.new
    b = Board.new
    key_1 = ["A","A"]
    index_1 = [1,3]

    assert_equal ["A1","A2","A3"], pl.interpret_if_same_letter(key_1,index_1,b.grid)
  end

  def test_it_can_interpret_array_when_same_index
    pl = Player.new
    b = Board.new
    key_2 = ["B","D"]
    index_2 = [1,1]

    assert_equal ["B1","C1","D1"], pl.interpret_if_same_index(key_2,index_2, b.grid)
  end
end
