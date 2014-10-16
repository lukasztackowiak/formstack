# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'formstack/version'

Gem::Specification.new do |spec|
  spec.name          = "formstack"
  spec.version       = Formstack::VERSION
  spec.authors       = ["Wynn Netherland"]
  spec.email         = ["wynn.netherland@gmail.com}"]
  spec.summary       = %q{Wrapper for the Formstack API}
  spec.description   = %q{Wrapper for the Formstack API}
  spec.homepage      = %q{http://github.com/pengwynn/formstack}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'hashie'
  spec.add_dependency 'httparty'

  spec.add_development_dependency 'shoulda'
  spec.add_development_dependency 'fakeweb'
end