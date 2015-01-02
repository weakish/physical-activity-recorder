source 'https://rubygems.org'

# Before bundle 2.0, `:github` uses insecure `git` protocol.
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  opts["git"] = "https://github.com/#{repo_name}.git"
end

# Specify your gem's dependencies in physical-activity-recorder-activity-recorder.gemspec
gemspec
