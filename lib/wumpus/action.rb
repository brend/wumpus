module WumpusHunt
  class Action  
    attr_reader :message
  
    def Action.valid?(a)
      [TURN, FORWARD, SHOOT, GRAB, CLIMB].include?(a)
    end
    
    def Action.from_sym(s)
      [TURN, FORWARD, SHOOT, GRAB, CLIMB].find {|a| a.message == s}
    end
  
    def initialize(message)
      @message = message
    end
  
    def apply(target)
      target.send(message)
    end
    
    def to_s
      message.to_s
    end
  
    TURN    = Action.new(:turn)
    FORWARD = Action.new(:forward)
    SHOOT   = Action.new(:shoot)
    GRAB    = Action.new(:grab)
    CLIMB   = Action.new(:climb)
  end
end