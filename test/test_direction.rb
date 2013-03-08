require 'test/unit'
require 'wumpus/direction'
require 'mocks'

class TestDirection < Test::Unit::TestCase
  include WumpusHunt
  
  def test_offset
    assert_equal([0, 1], [Direction::UP.x_offset, Direction::UP.y_offset])
    assert_equal([1, 0], [Direction::RIGHT.x_offset, Direction::RIGHT.y_offset])
    assert_equal([0, -1], [Direction::DOWN.x_offset, Direction::DOWN.y_offset])
    assert_equal([-1, 0], [Direction::LEFT.x_offset, Direction::LEFT.y_offset])
  end
  
  def test_turn
    assert_equal(Direction::RIGHT, Direction::UP.turn)
    assert_equal(Direction::DOWN, Direction::RIGHT.turn)
    assert_equal(Direction::LEFT, Direction::DOWN.turn)
    assert_equal(Direction::UP, Direction::LEFT.turn)
  end
  
  def test_apply
    c = MockCave.new
    c.hunter_location = [2, 3]
    
    Direction::LEFT.apply(c)
    assert_equal([1, 3], c.hunter_location)
  end
  
  def test_add_to
    assert_equal([1, 3], Direction::UP.add_to([1, 2]))
    assert_equal([1, 3], Direction::RIGHT.add_to([0, 3]))
    assert_equal([0, 0], Direction::LEFT.add_to([1, 0]))
    assert_equal([0, 0], Direction::DOWN.add_to([0, 1]))
    assert_nil(Direction::LEFT.add_to([0, 2]))
  end
  
end
