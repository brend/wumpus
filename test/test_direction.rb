require 'test/unit'
require 'wumpus/direction'

class TestDirection < Test::Unit::TestCase
  def test_turn
    assert_equal(Direction::RIGHT, Direction.turn(Direction::UP))
    assert_equal(Direction::DOWN, Direction.turn(Direction::RIGHT))
    assert_equal(Direction::LEFT, Direction.turn(Direction::DOWN))
    assert_equal(Direction::UP, Direction.turn(Direction::LEFT))
  end  
end
