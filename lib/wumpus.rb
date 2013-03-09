require 'wumpus/cave'

class UsageError < Exception; end

class Array
  def mean
    inject(0) {|a, b| a + b} / length.to_f
  end
  
  def median
    return nil if empty?
    sort[length / 2]
  end
end

def tournament(game_count)
  scores = []
  game_count.times do |i|
    h = Hunter.new
    c = WumpusHunt::Cave.new(h)
    c.randomize
    scores << c.hunt
  end
  scores
end

def hunt_the_hunt
  # Load the hunter from the provided file
  raise UsageError.new("Usage: wumpus.rb <hunter file> <number of games>") if ARGV.count != 2
  raise UsageError.new("Provided hunter file doesn't exist: #{ARGV.first}") unless File.exist?(ARGV.first)

  n = ARGV[1].to_i

  raise UsageError.new("Please provide the number of games to be played") if n < 1

  require ARGV.first

  raise UsageError.new("Class 'Hunter' has not been defined") unless defined?(Hunter)

  h = Hunter.new

  raise UsageError.new("Class 'Hunter' doesn't respond to 'make_move'.") unless h.respond_to?(:make_move)

  scores = tournament(n)
  
  # Print the results
  puts "*** Scores (#{n} games)"
  puts scores
  puts "*** Average: #{scores.mean}"
  puts "*** Median: #{scores.median}"
end

begin
  hunt_the_hunt
rescue UsageError => e
  STDERR.puts e
end
