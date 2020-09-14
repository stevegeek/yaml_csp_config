# frozen_string_literal: true

module ActionDispatch
  # Reopen class and add new method
  class ContentSecurityPolicy
    def load_from_yml
      YamlCspConfig::YamlLoader.call(self)
    end
  end
end
