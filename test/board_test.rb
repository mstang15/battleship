require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/space'
require './lib/board'


class BoardTest <Minitest::Test

  def test_it_exists
    b = Board.new

    assert_instance_of Board, b
  end

  def test_grid_is_empty_to_begin
    b = Board.new

    assert b.empty_playing_grid["A"][0].empty
    assert b.empty_playing_grid["A"][1].empty
    assert b.empty_playing_grid["A"][2].empty
    assert b.empty_playing_grid["A"][3].empty
    assert b.empty_playing_grid["B"][0].empty
    assert b.empty_playing_grid["B"][1].empty
    assert b.empty_playing_grid["B"][2].empty
    assert b.empty_playing_grid["B"][3].empty
    assert b.empty_playing_grid["C"][0].empty
    assert b.empty_playing_grid["C"][1].empty
    assert b.empty_playing_grid["C"][2].empty
    assert b.empty_playing_grid["C"][3].empty
    assert b.empty_playing_grid["D"][0].empty
    assert b.empty_playing_grid["D"][1].empty
    assert b.empty_playing_grid["D"][2].empty
    assert b.empty_playing_grid["D"][3].empty
  end

end
