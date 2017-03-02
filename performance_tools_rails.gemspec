$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "performance_tools_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "performance_tools_rails"
  s.version     = PerformanceToolsRails::VERSION
  s.authors     = ["Mick Mehigan"]
  s.email       = ["michael.mehigan@sage.com"]
  s.homepage    = ""
  s.summary     = "Rails wrapper of PerformanceTools."
  s.description = "Rails wrapper of PerformanceTools."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"
end
