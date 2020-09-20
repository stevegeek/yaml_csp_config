# frozen_string_literal: true

require "rails/generators/base"

module YamlCspConfig
  module Generators
    # The Install generator `yaml_csp_config:install`
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path(__dir__)

      desc "Creates an initial basic YAML configuration, an initializer and configures Rails to use the gem."
      def copy_tasks
        template "templates/yaml_csp_config.rb", "config/initializers/yaml_csp_config.rb"
        template "templates/content_security_policy.yml", "config/content_security_policy.yml"
      end
    end
  end
end
