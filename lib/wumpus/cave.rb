
class Cave
  attr_accessor :hunter
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
    0
  end
  
  def randomize
    # Place 'start'
    self[rand(4), rand(4)].start = true
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
  end
end
