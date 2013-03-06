
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
end