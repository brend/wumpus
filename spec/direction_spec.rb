require 'wumpus/direction'

include WumpusHunt

describe Direction do
  it "has constants with correct offsets" do
    [Direction::UP.x_offset, Direction::UP.y_offset].should eq([0, 1])
    [Direction::RIGHT.x_offset, Direction::RIGHT.y_offset].should eq([1, 0])
    [Direction::DOWN.x_offset, Direction::DOWN.y_offset].should eq([0, -1])
    [Direction::LEFT.x_offset, Direction::LEFT.y_offset].should eq([-1, 0])
  end
  
  it "turns correctly" do
    Direction::UP.turn.should eq(Direction::RIGHT)
    Direction::RIGHT.turn.should eq(Direction::DOWN)
    Direction::DOWN.turn.should eq(Direction::LEFT)
    Direction::LEFT.turn.should eq(Direction::UP)
  end
  
  it "alters the hunter location when applied" do
    c = double(:hunter_location => [3, 2])
    c.should_receive(:hunter_location=).with([2, 2])
    Direction::LEFT.apply(c)
  end
  
  describe "#add" do
    it "should add its offset to a point" do
      Direction::UP.add_to([1, 2]).should eq([1, 3])
      Direction::RIGHT.add_to([0, 3]).should eq([1, 3])
      Direction::LEFT.add_to([1, 0]).should eq([0, 0])
      Direction::DOWN.add_to([0, 1]).should eq([0, 0])
    end
    
    it "should yield nil when resulting location is off-grid" do
      Direction::LEFT.add_to([0, 2]).should be_nil
    end
  end
end
