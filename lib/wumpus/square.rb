module WumpusHunt
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
  
    def dangerous?
      wumpus || pit
    end
  
    def to_s
      s = start ? "S" : ""
      w = wumpus ? "W" : ""
      p = pit ? "P" : ""
      g = gold ? "G" : ""
      "[#{[s, w, p, g].join}]"
    end
  end
end