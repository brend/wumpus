require 'test/unit'
require 'wumpus/senses'

class TestSenses < Test::Unit::TestCase
  include WumpusHunt
  
  def test_default_values
    s = Senses.new
    
    assert_equal(false, s.breeze)
    assert_equal(false, s.stench)
    assert_equal(false, s.glitter)
    assert_equal(false, s.scream)
    assert_equal(false, s.bump)
  end
  
  def test_accessors
    s = Senses.new
    
    s.breeze = true
    s.stench = true
    s.glitter = true
    s.scream = true
    s.bump = true
    
    assert(s.breeze)
    assert(s.stench)
    assert(s.glitter)
    assert(s.scream)
    assert(s.bump)
  end
end
