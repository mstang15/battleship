require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/space'
require './lib/board'
require 'pry'

class BoardTest <Minitest::Test

  def test_it_exists
    b = Board.new

    assert_instance_of Board, b
  end

end
