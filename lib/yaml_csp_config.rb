# frozen_string_literal: true

require "yaml_csp_config/railtie"
require "yaml_csp_config/csp_ext"
require "yaml_csp_config/yaml_loader"

# Exposes a configuration class for initializer
module YamlCspConfig
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration) if block_given?
    end
  end

  # Configuration class for initializer
  class Configuration
    attr_accessor :configuration_file_path,
                  :default_env_var_additions_key_prefix,
                  :default_env_var_group_key,
                  :yaml_config_base_key

    def initialize
      @configuration_file_path = Rails.root.join("config", "content_security_policy.yml")
      @default_env_var_additions_key_prefix = "CSP_CONFIGURATION_ADDITIONS_"
      @default_env_var_group_key = "CSP_CONFIGURATION_GROUP_KEY"
      @yaml_config_base_key = "content_security_policy"
    end
  end
end
