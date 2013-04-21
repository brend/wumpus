require 'wumpus/cave'

module WumpusHunt
  class Replay
    @replays = []
  
    def Replay.replays
      @replays
    end
  
    def Replay.add(world, action_map)
      @replays << Replay.new(world, action_map)
    end
  
    def Replay.clear
      @replays.clear
    end
  
    attr_reader :world, :action_map
  
    def initialize(world, action_map)
      @world = world
      @action_map = action_map
    end
  
    def play
      action_map.each do |hunter_name, actions|
        puts "### Now replaying #{hunter_name || '<No Name>'}"
        hunter = RHunter.new(actions, hunter_name)
        cave = Cave.new(hunter, world)
        cave.hunt
      end
    end
  
    # A hunter implementation that simply replays
    # the supplied actions
    class RHunter
      def initialize(a, name = nil)
        @actions = a.reverse
        @name = name
      end
    
      def make_move(senses)
        raise Exception 'No more actions left' if @actions.empty?
        @actions.pop
      end
    end
  end

  def clear_replays
    Replay.clear
  end

  def add_replay(world, action_map)
    Replay.add world, action_map
  end
end
