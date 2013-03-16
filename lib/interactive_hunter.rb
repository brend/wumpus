require 'wumpus/action'
require 'wumpus/direction'

class Hunter
  def initialize
    @move_count = 0
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
            
      case choice
      when 't'
        return WumpusHunt::Action::TURN
      when 'f'
        return WumpusHunt::Action::FORWARD
      when 's'
        return WumpusHunt::Action::SHOOT
      when 'g'
        return WumpusHunt::Action::GRAB
      when 'c'
        return WumpusHunt::Action::CLIMB
      else
        puts "### I-Hunter: Pick one of [tfsgc]!"
      end
    end
  end
end
