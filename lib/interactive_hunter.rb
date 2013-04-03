require 'wumpus/action'
require 'wumpus/direction'

class Hunter
  def initialize
    @move_count = 0
    @action_map = { 't' => :turn,
                    'f' => :forward,
                    's' => :shoot,
                    'g' => :grab,
                    'c' => :climb }
  end
  
  def make_move(senses)
    @move_count += 1
    action = decide(senses)
    puts "### I-Hunter: I will #{action}"
    action
  end
  
  def decide(senses)    
    while true
      puts "### I-Hunter: Move ##{@move_count}; I sense #{senses}; "
      print "### I-Hunter: Pick an action out of [t]urn, [f]orward, [s]hoot, [g]rab, [c]limb: "
      
      choice = STDIN.gets.chomp.downcase
      action = @action_map[choice]
      
      return action if action
      
      puts "### I-Hunter: Pick one of [tfsgc]!"
    end
  end
end
