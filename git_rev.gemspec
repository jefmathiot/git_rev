# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_rev/version'

Gem::Specification.new do |spec|
  spec.name          = "git_rev"
  spec.version       = GitRev::VERSION
  spec.authors       = ["Jef Mathiot"]
  spec.email         = ["jeff.mathiot@gmail.com"]
  spec.summary       = %q{Retrieve the git revision}
  spec.description   = %q{Get the git revision of a given repository. Does not require Git binaries}
  spec.homepage      = "http://github.com/servebox/git_rev"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'minitest', '~> 5.4', '>= 5.4.1'
  spec.add_development_dependency 'minitest-implicit-subject', '~> 1.4', '>= 1.4.0'
  spec.add_development_dependency 'rb-readline', '~> 0.5', '>= 0.5.0'
  spec.add_development_dependency 'guard', '~> 2.11', '>= 2.11.1'
  spec.add_development_dependency 'guard-minitest', '~> 2.3', '>= 2.3.2'

end
