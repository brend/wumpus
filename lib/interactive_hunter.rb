require 'wumpus/action'
require 'wumpus/direction'

class Hunter
  def initialize
    @move_count = 0
  end
  
  def make_move(senses)
    @move_count += 1
    puts "move ##{@move_count}; I sense #{senses}; "
    action = decide(senses)
    puts "I will #{action}"
    
    action
  end
  
  def decide(senses)
    puts "Pick an action: [t]urn, [f]orward, [s]hoot, [g]rab, [c]limb"
    
    while true
      choice = STDIN.gets.chomp.downcase
      
      puts "You have picked '#{choice}'"
      
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
        puts "Pick one of [tfsgc]"
      end
    end
  end
end
