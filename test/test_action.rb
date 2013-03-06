require 'test/unit'
require 'wumpus/action'

class TestAction < Test::Unit::TestCase
  def test_valid
    assert(Action.valid?(Action::TURN))
    assert(Action.valid?(Action::SHOOT))
    assert(Action.valid?(Action::FORWARD))
    assert(Action.valid?(Action::GRAB))
    assert(Action.valid?(Action::CLIMB))
    assert(!Action.valid?(17))
    assert(!Action.valid?(nil))
  end  
end
