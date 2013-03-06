
class Action
  TURN    = :turn
  FORWARD = :forward
  SHOOT   = :shoot
  GRAB    = :grab
  CLIMB   = :climb
  
  def Action.valid?(a)
    [TURN, FORWARD, SHOOT, GRAB, CLIMB].include?(a)
  end
end
