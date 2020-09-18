# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "yaml_csp_config/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "yaml_csp_config"
  spec.version     = YamlCspConfig::VERSION
  spec.authors     = ["Stephen Ierodiaconou"]
  spec.email       = ["stevegeek@gmail.com"]
  spec.homepage    = "https://github.com/stevegeek/yaml_csp_config"
  spec.summary     = "YamlCspConfig extends ActionDispatch::ContentSecurityPolicy with a method to load configuration" \
                       " from a YAML file. "
  spec.description = "The CSP configuration can also be extended by environment variables."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.required_ruby_version = ">= 2.6"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0"

  spec.add_development_dependency "rbs_rails"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "steep"
  spec.add_development_dependency "sqlite3"
end
