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

  def test_it_can_interpret_cruiser_coordinates
  end 

end
