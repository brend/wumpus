require 'wumpus/cave'

# Load the hunter from the provided file
raise Exception.new("Command line argument needed: hunter file") if ARGV.count == 0

require ARGV.first

raise Exception.new("Class 'Hunter' has not been defined") unless defined?(Hunter)

h = Hunter.new

raise Exception.new("Class 'Hunter' doesn't respond to 'make_move'.") unless h.respond_to?(:make_move)

c = WumpusHunt::Cave.new(h)
c.randomize
c.hunt
