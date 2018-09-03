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

  def test_hit_or_miss
    g = Game.new
    b
  end

end
