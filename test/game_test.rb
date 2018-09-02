require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship'
require 'pry'

class BattleshipTest <Minitest::Test
  def test_it_exists
    b = Battleship.new

    assert_instance_of Battleship, b
  end


end
