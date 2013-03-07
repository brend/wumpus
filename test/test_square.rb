require 'test/unit'
require 'wumpus/square'
require 'mocks'

class TestSquare < Test::Unit::TestCase
  def setup
    @s = Square.new
    @r = MockSenses.new
  end
  
  def test_default_values
    assert(!@s.gold)
    assert(!@s.wumpus)
    assert(!@s.pit)
    assert(!@s.start)
  end
  
  def test_accessors
    @s.gold = true
    @s.wumpus = true
    @s.pit = true
    @s.start = true
    
    assert(@s.gold)
    assert(@s.wumpus)
    assert(@s.pit)
    assert(@s.start)
  end
  
  def test_apply_neighbor_wumpus
    @s.wumpus = true
    @s.apply_neighbor(@r)
    assert(@r.stench)
    assert(!@r.breeze)
    assert(!@r.glitter)
  end
  
  def test_apply_neighbor_pit    
    @s.pit = true
    @s.apply_neighbor(@r)
    assert(@r.breeze)
    assert(!@r.stench)
    assert(!@r.glitter)
  end
    
  def test_apply_neighbor_gold
    @s.gold = true
    @s.apply_neighbor(@r)
    assert(!@r.glitter)
  end
  
  def test_apply_center_wumpus
    @s.wumpus = true
    @s.apply_center(@r)
    assert(!@r.stench)
    assert(!@r.breeze)
    assert(!@r.glitter)
  end
  
  def test_apply_center_pit
    @s.pit = true
    @s.apply_center(@r)
    assert(!@r.stench)
    assert(!@r.breeze)
    assert(!@r.glitter)
  end
  
  def test_apply_center_gold
    @s.gold = true
    @s.apply_center(@r)
    assert(!@r.stench)
    assert(!@r.breeze)
    assert(@r.glitter)
  end
  
  def test_occupied
    assert(!@s.occupied)
    
    @s.wumpus = true
    assert(@s.occupied)
    
    @s.wumpus = false
    @s.gold = true
    assert(@s.occupied)
    
    @s.gold = false
    @s.pit = true
    assert(@s.occupied)
    
    @s.pit = false
    @s.start = true
    assert(@s.occupied)
    
    @s.start = false
    assert(!@s.occupied)
  end
  
  def test_dangerous?
    assert(!@s.dangerous?)
    @s.wumpus = true
    assert(@s.dangerous?)
    @s.wumpus = false
    assert(!@s.dangerous?)
    @s.pit = true
    assert(@s.dangerous?)
    @s.pit = false
    @s.start = true
    @s.gold = true
    assert(!@s.dangerous?)
  end
end
