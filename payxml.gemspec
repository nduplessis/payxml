# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payxml/version'

Gem::Specification.new do |spec|
  spec.name          = "payxml"
  spec.version       = PayXML::VERSION
  spec.authors       = ["Nico du Plessis"]
  spec.email         = ["duplessis.nico@gmail.com"]

  spec.summary       = %q{A wrapper for the PayGate PayXML API.}
  spec.description   = %q{PayXML is an easy use wrapper for the the PayGate PayXML payment gateway API.}
  spec.homepage      = "https://github.com/nduplessis/payxml"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '~> 2.0'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "nokogiri"
end
