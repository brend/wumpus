require 'test/unit'
require 'set'
require 'wumpus/cave'
require 'wumpus/action'
require 'wumpus/direction'
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
  
  def test_randomize
    @c.randomize
    assert_not_nil(@c.hunter_location)
    assert_not_nil(@c.hunter_direction)
    assert(@c.hunter_arrow)
  end
  
  def test_hunter
    assert_equal(@h, @c.hunter)
  end
  
  def test_squares
    assert_equal(4 * 4, @c.squares.length)
  end
  
  def test_hunter_location
    @c.hunter_location = [1, 3]
    assert_equal([1, 3], @c.hunter_location)
    
    @c.randomize
    
    hx, hy = nil, nil
    0.upto(3) do |x|
      0.upto(3) do |y|
        if @c[x, y].start
          hx, hy = x, y
          break
        end
      end
    end
    
    assert_equal([hx, hy], @c.hunter_location)
  end
  
  def test_hunter_location_bounds
    # An invalid location mustn't be stored
    @c.hunter_location = [4, 2]
    assert_not_equal([4, 2], @c.hunter_location)
  end
  
  def test_hunter_direction
    @c.hunter_direction = Direction::DOWN
    assert_equal(Direction::DOWN, @c.hunter_direction)
    
    @c.randomize
    assert_equal(Direction::UP, @c.hunter_direction)
    
    assert_raise(ArgumentError) { @c.hunter_direction = nil }
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
    h.should_receive(:turn).at_least.once.and_return(Action::TURN)
    
    @c.hunter = h
    @c.randomize
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
  
  def test_turn
    @c.hunter_direction = Direction::UP
    @c.turn
    assert_equal(Direction::RIGHT, @c.hunter_direction)
  end
  
  def test_just_bumped
    @c.just_bumped
  end
  
  def test_forward
    @c.randomize
    assert_not_nil(@c.hunter_direction)
    @c.forward
  end
  
  def test_forward_bump
    @c.randomize
    @c.hunter_location = [0, 1]
    @c.hunter_direction = Direction::LEFT
    @c.forward
    assert(@c.just_bumped)
  end
  
  def test_shoot
    @c.shoot
  end
  
  def test_hunter_arrow
    @c.hunter_arrow = true
    assert(@c.hunter_arrow)
    @c.hunter_arrow = false
    assert(!@c.hunter_arrow)
  end
  
  def test_shoot_removes_arrow
    @c.randomize
    @c.hunter_arrow = true
    @c.shoot
    assert(!@c.hunter_arrow)
  end
  
  def test_shoot_on_wumpus
    @c[0, 3].wumpus = true
    @c.hunter_location = [0, 0]
    @c.hunter_direction = Direction::UP
    @c.hunter_arrow = true
    
    @c.shoot
    assert(!@c[0, 3].wumpus)
  end
  
  def test_shoot_miss_wumpus
    @c[0, 3].wumpus = true
    @c.hunter_location = [1, 0]
    @c.hunter_direction = Direction::UP
    @c.hunter_arrow = true
    
    @c.shoot
    assert(@c[0, 3].wumpus)
  end
  
  def test_grab
    @c[0, 0].gold = false
    @c.hunter_location = [0, 0]
    @c.grab
    assert(!@c[0, 0].gold)
    
    @c[0, 0].gold = true
    @c.grab
    assert(!@c[0, 0].gold)
  end
  
  def test_climb
    @c.start_location = [2, 3]
    @c.hunter_location = [1, 2]
    @c.climb
    assert(!@c.completed)
    
    @c.hunter_location = [2, 3]
    @c.climb
    assert(@c.completed)
  end
  
  def test_dangerous_positions
    @c[0, 2].pit = true
    @c[2, 1].wumpus = true
    @c[1, 1].gold = true
    @c[3, 3].pit = true
    
    assert_equal(Set.new([[0, 2], [2, 1], [3, 3]]), Set.new(@c.dangerous_positions))
  end
  
  def test_hunter_dead?
    @c[0, 2].pit = true
    @c[2, 1].wumpus = true
    @c[1, 1].gold = true
    @c[3, 3].pit = true
    @c.hunter_location = [2, 1]
    assert(@c.hunter_dead?)
    @c.hunter_location = [1, 1]
    assert(!@c.hunter_dead?)
    @c.hunter_location = [2, 1]
    assert(@c.hunter_dead?)
  end
  
  def test_action_count
    @c.randomize
    assert_equal(0, @c.action_count)
    @c.turn
    @c.turn
    @c.forward
    @c.shoot
    @c.climb
    @c.grab
    assert_equal(6, @c.action_count)
  end
end
