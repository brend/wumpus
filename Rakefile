require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

task :hunt, :hunter_file, :game_count do |t, args|
  hunter_file = args[:hunter_file]
  game_count = args[:game_count]
  ruby "-Ilib lib/wumpus.rb #{hunter_file} #{game_count}"
end
