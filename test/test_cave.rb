require 'test/unit'
require 'wumpus/cave'
require 'flexmock/test_unit'

class TestCave < Test::Unit::TestCase
  def setup
    @h = Object.new
    @c = Cave.new(@h)
  end
  
  def teardown
    @h = nil
    @c = nil
  end
  
  def test_hunter
    assert_equal(@h, @c.hunter)
  end
  
  def test_squares
    assert_equal(4 * 4, @c.squares.length)
  end
  
  def test_some_action_on_the_board
    @c.randomize
    assert(@c.squares.any? {|s| s.gold})
    assert(@c.squares.any? {|s| s.pit})
    assert(@c.squares.any? {|s| s.wumpus})
    assert(@c.squares.any? {|s| s.start})
  end
  
  # TODO: Find out why this never fails, even if :turn is never sent
  def test_hunt
    h = flexmock()
    h.should_receive(:turn).at_least.once
    
    @c.hunter = h
    @c.hunt
  end
  
  def test_square_access
    0.upto(3) do |y|
      0.upto(3) do |x|
        assert_not_nil(@c[x, y], "x=#{x},y=#{y}")
      end
    end
    
    assert_nil(@c[-1, 0])
    assert_nil(@c[3, 5])
    assert_nil(@c[5, 1])
    
    o = Object.new
    
    @c[3, 1] = o
    
    assert_equal(o, @c[3, 1])
    assert_raise(IndexError) { @c[4, 0] = o }
  end
  
  def test_squares_are_returned
    s = @c[1, 3]
    
    assert_respond_to(s, :gold)
  end
  
  def test_squares_are_distinct
    s, t = @c[0, 2], @c[1, 3]
    
    assert(s != t)
  end
  
  def test_get_senses
    @c[1, 2].wumpus = true
    @c[2, 0].gold = true
    @c[2, 2].pit = true
    @c[3, 3].pit = true
    
    r = @c.get_senses(0, 0)
    assert(!r.stench)
    assert(!r.breeze)
    assert(!r.glitter)
    assert(!r.scream)
    assert(!r.bump)
    
    r = @c.get_senses(1, 1)
    assert(r.stench)
    assert(!r.breeze)
    assert(!r.glitter)
    
    r = @c.get_senses(2, 1)
    assert(!r.stench)
    assert(r.breeze)
    assert(!r.glitter)
    
    r = @c.get_senses(2, 0)
    assert(!r.stench)
    assert(!r.breeze)
    assert(r.glitter)
    
    assert_nil(@c.get_senses(4, 0))
  end
  
end
