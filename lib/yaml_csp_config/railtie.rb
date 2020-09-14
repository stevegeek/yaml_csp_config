# frozen_string_literal: true

module YamlCspConfig
  # Include rake tasks
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/yaml_csp_config_tasks.rake"
    end
  end
end
