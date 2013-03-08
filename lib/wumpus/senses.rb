module WumpusHunt
  class Senses
    attr_accessor :breeze, :stench, :glitter, :bump, :scream
  
    def initialize
      @breeze = false
      @stench = false
      @glitter = false
      @bump = false
      @scream = false
    end
    
    def to_s
      b = breeze ? "a breeze" : nil
      s = stench ? "a stench" : nil
      g = glitter ? "a glitter" : nil
      p = bump ? "a bump" : nil
      c = scream ? "a scream" : nil
      all = [c,p,s,b,g].compact
      
      return '[nothing]' if all.empty?
      
      "[#{all.join(', ')}]"
    end
  end
end