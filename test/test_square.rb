require 'test/unit'
require 'wumpus/square'

class TestSquare < Test::Unit::TestCase
  def setup
    @s = Square.new
  end
  
  def test_default_values
    assert(!@s.gold)
    assert(!@s.wumpus)
    assert(!@s.pit)
    assert(!@s.start)
  end
  
  def test_gold
    @s.gold = true
    @s.wumpus = true
    @s.pit = true
    @s.start = true
    
    assert(@s.gold)
    assert(@s.wumpus)
    assert(@s.pit)
    assert(@s.start)
  end
end
