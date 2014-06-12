# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'calculation_timeframe/version'

Gem::Specification.new do |spec|
  spec.name          = "calculation_timeframe"
  spec.version       = CalculationTimeframe::VERSION
  spec.authors       = ["Thomas Jacobs"]
  spec.email         = ["JacobsT@businessLogic.com"]
  spec.description   = %q{Turns strings describing timeframes into a timeframe}
  spec.summary       = %q{Turns a string such as '1mo' or '3yr' into a timeframe.  A timeframe has
                          a start and end time. The end time is typically the current date and the
                          start time is the time described by the string such as 1 month ago}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "activesupport"
end
