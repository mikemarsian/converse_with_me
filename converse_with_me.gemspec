# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'converse_with_me/version'

Gem::Specification.new do |spec|
  spec.name          = "converse_with_me"
  spec.version       = ConverseWithMe::VERSION
  spec.authors       = ["Mike Polischuk"]
  spec.email         = ["mike@polischuk.net"]
  spec.summary       = %q{Adding gmail-like chat to your web app should be easy.}
  spec.homepage      = "http://github.com/mikemarsian/converse_with_me"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = "bin"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.2"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "webmock"
  #spec.add_development_dependency 'database_cleaner'

  spec.add_dependency 'activesupport', '~> 4'
  spec.add_dependency 'actionpack', '~> 4'
  spec.add_dependency "xmpp4r", "~> 0.5"
  spec.add_dependency "mikemarsian-ruby_bosh", "~> 0.13"
  spec.add_dependency "conversejs-rails"
  spec.add_dependency "gon", "~> 6.0"

  spec.description   = <<desc
Add description here
desc

end
