
class Square
  attr_accessor :gold, :wumpus, :pit, :start
  
  def apply_neighbor(senses)
    senses.stench |= self.wumpus
    senses.breeze |= self.pit
  end
  
  def apply_center(senses)
    senses.glitter = self.gold
  end
  
  def occupied
    gold || wumpus || pit || start
  end
end
