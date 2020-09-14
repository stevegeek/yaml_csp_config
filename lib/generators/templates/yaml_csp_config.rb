# frozen_string_literal: true

YamlCspConfig.configure do |config|
  # The path to the configuration file
  # config.configuration_file_path = Rails.root.join("config", "content_security_policy.yml")

  # The prefix to the environment variables that can be used to add to specific directives, for example
  # `CSP_CONFIGURATION_ADDITIONS_SCRIPT_SRC = 'self https://host'`
  # config.default_env_var_additions_key_prefix = "CSP_CONFIGURATION_ADDITIONS_"

  # The environment variable that contains the name of the YAML k/v group to add to the base rules.
  # If this is set any rules in the given named group will add to the default base ones.
  # config.default_env_var_group_key = "CSP_CONFIGURATION_GROUP_KEY"

  # The route the YAML file key which contains the base rules.
  # config.yaml_config_base_key = "content_security_policy"
end

# Load the configuration file and configure the content security policy.
Rails.application.config.content_security_policy(&:load_from_yml)
