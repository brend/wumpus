
class Cave
  attr_reader :hunter
  
  def initialize(h)
    @hunter = h
    @squares = Array.new(4 * 4) {Square.new}
    
  end
  
  def hunt
    0
  end
  
  def [](x, y)
    return nil if x < 0 || x > 3 || y < 0 || y > 3
    
    @squares[x + 4 * y]
  end
  
  def []=(x, y, v)
    raise IndexError if x < 0 || x > 3 || y < 0 || y > 3
    
    @squares[x + 4 * y] = v
  end
end