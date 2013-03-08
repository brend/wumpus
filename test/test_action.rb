require 'test/unit'
require 'flexmock/test_unit'
require 'wumpus/action'

class TestAction < Test::Unit::TestCase
  include WumpusHunt
  
  def test_valid
    assert(Action.valid?(Action::TURN))
    assert(Action.valid?(Action::SHOOT))
    assert(Action.valid?(Action::FORWARD))
    assert(Action.valid?(Action::GRAB))
    assert(Action.valid?(Action::CLIMB))
    assert(!Action.valid?(17))
    assert(!Action.valid?(nil))
  end
  
  def test_initialize
    a = Action.new(:shoot)
    
    assert_equal(:shoot, a.message)
  end
  
  def test_apply
    t = flexmock()
    t.should_receive(:shoot).once
    Action::SHOOT.apply(t)
  end
end
