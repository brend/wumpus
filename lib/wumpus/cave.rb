require 'wumpus/Direction'

class ProtocolBreach < Exception; end

class Cave
  attr_accessor :hunter, :hunter_location, :hunter_direction
  attr_reader :squares
  
  def initialize(h)
    @hunter = h
    @squares = Array.new(4 * 4) {Square.new}
  end
  
  def [](x, y)
    return nil if x < 0 || x > 3 || y < 0 || y > 3
    
    @squares[x + 4 * y]
  end
  
  def []=(x, y, v)
    raise IndexError if x < 0 || x > 3 || y < 0 || y > 3
    
    @squares[x + 4 * y] = v
  end
  
  def get_senses(x, y)
    return nil if x < 0 || x > 3 || y < 0 || y > 3
    
    s = Senses.new
    
    [-1, 1].each do |o|
      hn = self[x + o, y]
      hn.apply_neighbor(s) if hn
      vn = self[x, y + o]
      vn.apply_neighbor(s) if vn
    end
    
    self[x, y].apply_center(s)
    
    s
  end
  
  def hunt
    
    senses = get_senses(hunter_location.first, hunter_location.last)
    action = hunter.turn(senses)
    
    raise ProtocolBreach.new unless Action.valid?(action)
    
    
  end
  
  def randomize
    sx, sy = rand(4), rand(4)
    # Place 'start'
    self[sx, sy].start = true
    # Place 'gold
    while true
      x, y = rand(4), rand(4)
      unless self[x, y].occupied
        self[x, y].gold = true
        break
      end
    end
    # Place 'wumpus'
    while true
      x, y = rand(4), rand(4)
      unless self[x, y].occupied
        self[x, y].wumpus = true 
        break
      end
    end
    # Place 'pit'
    while true
      x, y = rand(4), rand(4)
      unless self[x, y].occupied
        self[x, y].pit = true 
        break
      end
    end
    # Place another 'pit'
    while true
      x, y = rand(4), rand(4)
      unless self[x, y].occupied
        self[x, y].pit = true 
        break
      end
    end
    
    # Prepare for the hunt
    self.hunter_location = [sx, sy]
    self.hunter_direction = Direction::UP
  end
end
