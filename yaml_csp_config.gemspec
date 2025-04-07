# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "yaml_csp_config/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = "yaml_csp_config"
  spec.version = YamlCspConfig::VERSION
  spec.authors = ["Stephen Ierodiaconou"]
  spec.email = ["stevegeek@gmail.com"]
  spec.homepage = "https://github.com/stevegeek/yaml_csp_config"
  spec.summary = "yaml_csp_config provides you with a way to manage your Rails CSP configuration via a YAML file."
  spec.description = "yaml_csp_config provides you with a way to manage your Rails 5.2+ CSP configuration via a YAML file. The CSP configuration can also be extended by environment variables."
  spec.license = "MIT"

  spec.required_ruby_version = ">= 3.0"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "sig/types.rbs"]

  spec.add_dependency "railties", ">= 7.0", "< 9.0"
  spec.add_dependency "activesupport", ">= 7.0", "< 9.0"

  spec.add_development_dependency "appraisal"
end
