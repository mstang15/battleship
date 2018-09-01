require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/space'

class SpaceTest < Minitest::Test
  def test_it_exists
    s = Space.new

    assert_instance_of Space, s
  end
end
