require 'wumpus/Direction'

class ProtocolBreach < Exception; end

class Cave
  attr_accessor :hunter, :start_location, :hunter_arrow, :action_count, :just_bumped, :just_killed_wumpus
  attr_reader :squares, :completed, :gold_grabbed
  
  def initialize(h)
    @hunter = h
    @squares = Array.new(4 * 4) {Square.new}
    @action_count = 0
  end
  
  def [](x, y)
    return nil unless valid_location?([x, y])
    
    @squares[x + 4 * y]
  end
  
  def []=(x, y, v)
    raise IndexError unless valid_location?([x, y])
    
    @squares[x + 4 * y] = v
  end
  
  def hunter_location
    @hunter_location
  end
  
  def hunter_location=(location)
    if valid_location?(location)
      @hunter_location = location
      @just_bumped = false
    else
      @just_bumped = true
    end
  end
  
  def hunter_direction
    @hunter_direction
  end
  
  def hunter_direction=(d)
    raise ArgumentError if d.nil?
    @hunter_direction = d
  end
  
  def valid_location?(location)
    x, y = location
    
    x >= 0 && x < 4 && y >= 0 && y < 4
  end
  
  def get_senses(x, y)
    return nil unless valid_location?([x, y])
    
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
    death_counter = 0
    
    while not completed
      senses = get_senses(self.hunter_location.first, self.hunter_location.last)
      action = self.hunter.turn(senses)
      
      raise ProtocolBreach.new unless Action.valid?(action)
      
      action.apply(self)
      
      # DEBUG
      death_counter += 1
      break if death_counter > 10
    end
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
    self.hunter_location = self.start_location = [sx, sy]
    self.hunter_direction = Direction::UP
    self.hunter_arrow = true
  end
  
  def climb
    @action_count += 1

    @completed = self.hunter_location == self.start_location
  end
  
  def forward
    @action_count += 1

    self.hunter_direction.apply(self)
  end
  
  def grab
    @action_count += 1

    x, y = self.hunter_location
    if self[x, y].gold
      @gold_grabbed = true
      self[x, y].gold = false
    end
  end
  
  def turn
    @action_count += 1

    self.hunter_direction = self.hunter_direction.turn
  end
  
  def shoot
    @action_count += 1

    return unless self.hunter_arrow
    
    arrow_location = self.hunter_location
    
    begin
      arrow_location = self.hunter_direction.add_to(arrow_location)
      
      break if arrow_location.nil?
      
      if self[arrow_location.first, arrow_location.last].wumpus
        self[arrow_location.first, arrow_location.last].wumpus = false
      end
    end while true
    
    self.hunter_arrow = false
  end
  
  def dangerous_positions
    dp = []
    0.upto(3) do |x|
      0.upto(3) do |y|
        dp << [x, y] if self[x, y].dangerous?
      end
    end
    dp
  end
  
  def hunter_dead?
    self.dangerous_positions.include?(self.hunter_location)
  end
end
