# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gb_work_day/version'

Gem::Specification.new do |spec|
  spec.name          = 'gb_work_day'
  spec.version       = GBWorkDay::VERSION
  spec.authors       = ['Kacper Kawecki']
  spec.email         = ['kacper@geniebelt.com']
  spec.summary       = %q{Library extending Time and Date to do calculations for work days}
  spec.description   = %q{Library extending Time and Date to do calculations for work days. Unlike others libraries it operates on whole days, not hours.}
  spec.homepage      = 'https://github.com/GenieBelt/gb-works-day'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'activesupport'
end
