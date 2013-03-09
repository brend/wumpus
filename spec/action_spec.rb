require 'wumpus/action'

include WumpusHunt

describe Action do
  it "has constants TURN, FORWARD, SHOOT, GRAB, and CLIMB" do
    defined?(Action::TURN).should be_true
    defined?(Action::FORWARD).should be_true
    defined?(Action::SHOOT).should be_true
    defined?(Action::GRAB).should be_true
    defined?(Action::CLIMB).should be_true
  end
  
  describe Action::TURN do
    it "should turn the target" do
      target = double()
      target.should_receive(:turn).once
      
      Action::TURN.apply(target)
    end
  end
  
  describe Action::FORWARD do
    it "should move the target forward" do
      target = double()
      target.should_receive(:forward).once
      
      Action::FORWARD.apply(target)
    end
  end
  
  describe Action::SHOOT do
    it "should make the target shoot" do
      target = double()
      target.should_receive(:shoot).once
      
      Action::SHOOT.apply(target)
    end
  end
  
  describe Action::GRAB do
    it "should make the target grab" do
      target = double()
      target.should_receive(:grab).once
      
      Action::GRAB.apply(target)
    end
  end
  
  describe Action::CLIMB do
    it "should make the target climb" do
      target = double()
      target.should_receive(:climb).once
      
      Action::CLIMB.apply(target)
    end
  end
  
  it "should remember the provided message name" do
    a = Action.new(:some_message)
    a.message.should eq(:some_message)
  end
  
  it "should validate existing constants" do
    Action.valid?(Action::TURN).should be_true
    Action.valid?(Action::FORWARD).should be_true
    Action.valid?(Action::SHOOT).should be_true
    Action.valid?(Action::GRAB).should be_true
    Action.valid?(Action::CLIMB).should be_true
  end
  
  it "should not validate non-action values" do
    Action.valid?(nil).should be_false
    Action.valid?(:forward).should be_false
    Action.valid?(2).should be_false
  end
  
  it "should not validate undefined actions" do
    Action.valid?(Action.new(:bubu)).should be_false
  end
end
