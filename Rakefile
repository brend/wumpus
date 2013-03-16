require 'rake/testtask'
require 'rspec/core/rake_task'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

task :hunt, :hunter_file, :game_count, :logging do |t, args|
  hunter_file = args[:hunter_file]
  game_count = args[:game_count]
  logging = args[:logging].to_i != 0
  ruby "-Ilib lib/wumpus.rb #{hunter_file} #{game_count} #{logging}"
end


RSpec::Core::RakeTask.new(:spec)
