require 'test/unit'
require 'wumpus/cave'

class TestCave < Test::Unit::TestCase
  def test_initialize
    h = Object.new
    c = Cave.new(h)
  end
  
  def test_hunter
    h = Object.new
    c = Cave.new(h)
    
    assert_equal(h, c.hunter)
  end
  
  def test_play
    h = Object.new
    c = Cave.new(h)
    
    score = c.hunt
    
    assert_not_nil(score)
  end
end
