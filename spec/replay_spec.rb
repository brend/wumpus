require 'wumpus/replay'

describe Replay do
  it "defines a method that builds a list of replays" do
    add_replay nil, nil
  end
  
  it "provides a list of replays" do
    Replay.replays
  end
  
  it "adds replays to the list" do
    world = [[1,0], [2,3], [[0,1], [[2,2], [2,3]]]]
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
