module WumpusHunt
  class Direction
    attr_accessor :name, :x_offset, :y_offset
  
    def initialize(name, x_offset, y_offset)
      @name = name
      @x_offset = x_offset
      @y_offset = y_offset
    end
  
    UP = Direction.new('up', 0, 1)
    RIGHT = Direction.new('right', 1, 0)
    DOWN = Direction.new('down', 0, -1)
    LEFT = Direction.new('left', -1, 0)
    SEQUENCE = [UP, RIGHT, DOWN, LEFT]
  
    def turn
      SEQUENCE[(SEQUENCE.index(self) + 1) % SEQUENCE.length]
    end
  
    def apply(c)
      x, y = c.hunter_location
      c.hunter_location = [x + x_offset, y + y_offset]
    end
  
    def add_to(location)
      x, y = location
      sx, sy = x + x_offset, y + y_offset
    
      return nil if sx < 0 || sx > 3 || sy < 0 || sy > 3
    
      [sx, sy]    
    end
  
    def to_s
      name
    end
  end
end