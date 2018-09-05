require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/player'
require './lib/ships'
require './lib/space'
require './lib/validate'
require 'pry'

class GameTest <Minitest::Test
  def test_it_exists
    g = Game.new

    assert_instance_of Game, g
  end

  def test_can_check_if_someone_won
    g = Game.new
    grid = {"A"=>[" S"," M", " ", " "], "B" => [" M"," S"," S", " ."]}
    grid_2 ={"A"=>[" S"," M", " ", " "], "B" => [" M"," S"," S", " ."], "C" =>[" M", " S", " .", " S"]}

    refute g.check_if_someone_won(grid)
    assert g.check_if_someone_won(grid_2)
  end

end
