require 'test/unit'
require 'wumpus/cave'

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
  
  def test_play
    score = @c.hunt
    
    assert_not_nil(score)
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
end
