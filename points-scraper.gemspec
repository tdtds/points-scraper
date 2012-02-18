# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "points-scraper/version"

Gem::Specification.new do |s|
  s.name        = "points-scraper"
  s.version     = Points::Scraper::VERSION
  s.authors     = ["TADA Tadashi"]
  s.email       = ["t@tdtds.jp"]
  s.homepage    = "https://github.com/tdtds/points-scraper"
  s.summary     = "getting mileages/points from shopping web sites."
  s.description = "getting mileages/points by web scraping shopping sites: T-SITE."

  s.rubyforge_project = "points-scraper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "mechanize"
  s.add_runtime_dependency "pit"
end
