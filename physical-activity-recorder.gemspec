# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'physical-activity-recorder/version'

Gem::Specification.new do |spec|
  spec.name          = 'physical-activity-recorder'
  spec.version       = Physical_activity_recorder::VERSION
  spec.authors       = ['Jakukyo Friel']
  spec.email         = ['weakish@gmail.com']
  spec.summary       = %q{Record and plan your physical activity.}
  spec.description   = %q{Record and plan your physical activity at moderate and vigorous levels.}
  spec.homepage      = 'https://github.com/weakish/physical-activity-recorder'
  spec.license       = 'MIT'

  spec.metadata      = {
                        'repository' => 'https://github.com/weakish/physical-activity-recorder.git',
                        'documentation' => 'http://www.rubydoc.info/gems/physical-activity-recorder/',
                        'issues' => 'https://github.com/weakish/physical-activity-recorder/issues/',
                        'wiki' => 'https://github.com/weakish/physical-activity-recorder/wiki/',
                       }

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.bindir        = 'bin'


  spec.add_runtime_dependency 'time-lord', '~> 1.0'
  spec.add_runtime_dependency 'moneta', '~> 0.8'
  spec.add_runtime_dependency 'daybreak', '~> 0.3'
  spec.add_runtime_dependency 'xdg', '~> 2.2'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'yard', '~> 0.8'
  spec.add_development_dependency 'redcarpet', '~> 3.2'
end
