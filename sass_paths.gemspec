# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sass_paths/version'

Gem::Specification.new do |spec|
  spec.name          = "sass_paths"
  spec.version       = SassPaths::VERSION
  spec.authors       = ["Stafford Brunk", "Jonathan Lehman"]
  spec.email         = ["sbrunk@customink.com", "jlehman@customink.com"]
  spec.summary       = %q{Helper methods to append directories to the SASS_PATH ENV variable}
  spec.description   = %q{This gem provides helper methods for appending directories, gems, and bower extensions to the SASS_PATH environment variable}
  spec.homepage      = "https://github.com/customink/sass_paths"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "susy"

  spec.add_dependency "sass", '~> 3.2'
end
