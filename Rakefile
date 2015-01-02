require 'bundler/gem_tasks'
require 'rake/clean'


task :default => :test

desc 'Run doctests'
task :test do
  sh 'bundle exec rubydoctest lib/*.rb'
end

desc 'Generate docs'
task('doc') { sh 'bundle exec yard doc' }
CLEAN.include 'doc'

