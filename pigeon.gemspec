lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pigeon/version'

Gem::Specification.new do |spec|
  spec.name        = 'Pigeon'
  spec.version     = '0.0.0'
  spec.date        = '2014-10-28'
  spec.summary     = 'A basic message passing gem'
  spec.description = 'An abstract implementation of message passing for Yerdle apps'
  spec.licenses    = []
  spec.authors     = ['Brent Haas']
  spec.email       = 'brenthaas@gmail.com'
  spec.files       = `git ls-files`.split($/)
  spec.test_files  = spec.files.grep(%r{^spec/})
  spec.homepage    = 'http://rubygems.org/gems/pigeon'

  # dependent gems
  spec.add_dependency 'bunny', '~> 1.5'
  spec.add_dependency 'msgpack', '~> 0.5'

  # development gems
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'bunny_mock', '~> 0.0'
  spec.add_development_dependency 'pry-byebug', '~> 2.0'
end
