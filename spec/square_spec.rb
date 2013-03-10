require 'wumpus/square'

include WumpusHunt

describe Square do
  it "uses 'false' as default values for all attributes" do
    s = Square.new
    s.gold.should be_false
    s.wumpus.should be_false
    s.pit.should be_false
    s.start.should be_false
  end
  
  it "should have working accessors" do
    s = Square.new
    s.gold = true
    s.wumpus = true
    s.pit = true
    s.start = true
    s.gold.should be_true
    s.wumpus.should be_true
    s.pit.should be_true
    s.start.should be_true
  end
  
  it "should put a stench on its surroundings if wumpus is present" do
    s = Square.new
    r = double(:stench => false, :breeze => false)
    r.should_receive(:stench=).with(true)
    r.should_receive(:breeze=).with(false)
    s.wumpus = true
    s.apply_neighbor(r)
  end
  
  it "should not put a stench on its surroundings if wumpus is absent" do
    s = Square.new
    r = double(:stench => false, :breeze => false, :breeze= => false)
    r.should_receive(:stench=).with(false)
    s.apply_neighbor(r)
  end

  it "should put a breeze on its surroundings if pit is present" do
    s = Square.new
    r = double(:stench => false, :stench= => false, :breeze => false)
    r.should_receive(:breeze=).with(true)
    s.pit = true
    s.apply_neighbor(r)
  end

  it "should not put a breeze on its surroundings if pit is absent" do
    s = Square.new
    r = double(:stench => false, :stench= => false, :breeze => false)
    r.should_receive(:breeze=).with(false)
    s.apply_neighbor(r)
  end
  
  it "should not put a glitter on its surroundings if gold is present" do
    s = Square.new
    r = double(:stench => false, :stench= => false, :breeze => false, :breeze= => false)
    r.should_not_receive(:glitter=).with(true)
    s.gold = true
    s.apply_neighbor(r)
  end

  it "should put a glitter on its own square if gold is present" do
    s = Square.new
    r = double(:stench => false, :breeze => false)
    r.should_receive(:glitter=).with(true)
    s.gold = true
    s.apply_center(r)
  end
  
  it "should be occupied iff wumpus, pit, start or gold is present" do
    s = Square.new
    s.occupied.should be_false
    
    s.wumpus = true
    s.occupied.should be_true
    
    s.wumpus = false
    s.gold = true
    s.occupied.should be_true
    
    s.gold = false
    s.pit = true
    s.occupied.should be_true
    
    s.pit = false
    s.start = true
    s.occupied.should be_true
    
    s.start = false
    s.occupied.should be_false
  end
  
  it "should be dangerous iff wumpus or pit are present" do
    s = Square.new
    s.dangerous?.should be_false
    
    s.wumpus = true
    s.dangerous?.should be_true
    
    s.wumpus = false
    s.pit = true
    s.dangerous?.should be_true
    
    s.pit = false
    s.start = true
    s.gold = true
    s.dangerous?.should be_false
  end
end
