# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "her_advanced/version"

Gem::Specification.new do |s|
  s.name        = "her-advanced"
  s.version     = HerAdvanced::VERSION
  s.authors     = ["Rémi Prévost", "M. E. Patterson"]
  s.email       = ["remi@exomel.com", "madraziel@gmail.com"]
  s.homepage    = "http://her-rb.org"
  s.license     = "MIT"
  s.summary     = "A (not-so-simple anymore) Representational State Transfer-based Hypertext Transfer Protocol-powered Object Relational Mapper. Her?"
  s.description = "HerAdvanced is an ORM that maps REST resources and collections to Ruby objects, hacked up by M. E. Patterson from the original Her gem at http://her-rb.org"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 2.13"
  s.add_development_dependency "rspec-its", "~> 1.0"
  s.add_development_dependency "fivemat", "~> 1.2"
  s.add_development_dependency "json", "~> 1.8"

  s.add_runtime_dependency "activemodel", ">= 3.0.0", "< 4.2"
  s.add_runtime_dependency "activesupport", ">= 3.0.0", "< 4.2"
  s.add_runtime_dependency "faraday", ">= 0.8", "< 1.0"
  s.add_runtime_dependency "multi_json", "~> 1.7"
end
