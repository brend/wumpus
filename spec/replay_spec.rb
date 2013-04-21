require 'wumpus/replay'

describe Replay do
  it "defines a method that builds a list of replays" do
    add_replay nil, nil
  end
  
  it "provides a list of replays" do
    Replay.replays
  end
  
  it "adds replays to the list" do
    world = {:start => [1,0], :gold => [2,3], :wumpus => [0,1], :pits => [[2,2], [2,3]]}
    action_map = {'Bronco' => [:turn, :forward, :turn, :turn, :forward, :shoot]}

    clear_replays
    add_replay world, action_map               
    Replay.replays.nil?.should be_false
    Replay.replays.length.should eq 1
    
    r = Replay.replays.first
    r.world.should eq world
    r.action_map.should eq action_map
    
    clear_replays
    Replay.replays.length.should eq 0
  end
end

describe Replay::RHunter do
  it "has a name and a sequence of actions" do
    h = Replay::RHunter.new('Testyboy', [:turn, :forward, :shoot])
  end
  
  it "yields the supplied actions" do
    a = [:turn, :turn, :forward, :shoot]
    h = Replay::RHunter.new(a)
    a.each do |x|
      h.make_move(nil).should eq x
    end
  end
  
  it "raises an error if asked for too many actions" do
    h = Replay::RHunter.new([:turn, :forward])
    h.make_move(nil)
    h.make_move(nil)
    expect {h.make_move(nil)}.to raise_error
  end
end

