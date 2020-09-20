require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)
require "yaml_csp_config"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    if Gem::Version.new(Rails::VERSION::STRING) >= Gem::Version.new("5.1.0")
      # Initialize configuration defaults for current Rails version.
      config.load_defaults "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Required for Rails 5.0 and 5.1
    config.secret_key_base = SecureRandom.hex
  end
end
