# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "curo/version"

Gem::Specification.new do |s|
  s.name          = "curo"
  s.version       = Curo::VERSION
  s.authors       = ["Mike Wagner"]
  s.description   = %q{Command line utility for tracking and tagging hosts.}
  s.summary       = %q{Command line utility for tracking and tagging hosts.}
  s.email         = %q{mwagner@digitalinsites.com}
  s.homepage      = %q{http://github.com/mikewagner/curo}
  s.licenses      = [%q{MIT}]

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables        = ["curo"]
  s.default_executable = %q{curo}
  s.require_paths      = ["lib"]
end

