# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rssh/version"

Gem::Specification.new do |s|
  s.name          = "rssh"
  s.version       = RSSH::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Mike Wagner"]
  s.description   = %q{Command line utility for tracking and tagging hosts.}
  s.summary       = %q{Command line utility for tracking and tagging hosts.}
  s.email         = %q{mwagner@digitalinsites.com}
  s.homepage      = %q{http://github.com/mikewagner/rssh}
  s.licenses      = [%q{MIT}]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = [%q{lib}]
end

