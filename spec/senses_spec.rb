require 'wumpus/senses'

include WumpusHunt

describe Senses do
  it "should have 'false' as default value for each attribute" do
    s = Senses.new
    s.stench.should be_false
    s.breeze.should be_false
    s.bump.should be_false
    s.glitter.should be_false
    s.scream.should be_false
  end
  
  it "should have working accessors" do
    s = Senses.new
    s.stench = true
    s.breeze = true
    s.bump = true
    s.glitter = true
    s.scream = true
    s.stench.should be_true
    s.breeze.should be_true
    s.bump.should be_true
    s.glitter.should be_true
    s.scream.should be_true
  end
end
