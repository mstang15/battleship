require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship'
require './lib/board'
require './lib/ships'
require './lib/space'
require './lib/player'
require 'pry'

class PlayerTest <Minitest::Test
  def test_it_exists
    pl = Player.new

    assert_instance_of Player, pl
  end

  def test_space_not_empty_when_destroyer_placed
    pl = Player.new
    b = Board.new
    pl.player_place_destroyer("A1 A2",b.grid)
    pl.player_place_destroyer("B1 C1",b.grid)

    refute b.grid["A"][0].empty
    refute b.grid["A"][1].empty
    refute b.grid["B"][0].empty
    refute b.grid["C"][0].empty
  end

  def test_space_not_empty_when_cruiser_placed
    pl = Player.new
    b = Board.new
    pl.player_place_cruiser("A1 A3",b.grid)
    pl.player_place_cruiser("B1 D1", b.grid)

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


end
