require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/space'


class SpaceTest < Minitest::Test
  def test_it_exists
    s = Space.new

    assert_instance_of Space, s
  end

  def test_spaces_start_out_empty
    s = Space.new

    assert s.empty
  end

  def test_spaces_arnt_hit_at_first
    s = Space.new

    refute s.hit
  end

  def test_ship_present_false_to_begin
    s = Space.new

    refute s.ship_present
  end

  def sunk_is_false_to_begin
    s = Space.new

    refute s.sunk
  end

  def test_hit_is_true_when_guessed
    s = Space.new

    assert s.guess
  end

  def test_sunk_is_true_when_sink
    s = Space.new

    assert s.sink
  end

end
