source 'https://rubygems.org'

# Before bundle 2.0, `:github` uses insecure `git` protocol.
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Specify your gem's dependencies in physical-activity-recorder-activity-recorder.gemspec
gemspec

# Need to use my branch of rubydoctest.
gem 'rubydoctest', github: 'weakish/rubydoctest', branch: 'weakish'
