require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application
    config.load_defaults "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"

    config.secret_key_base = SecureRandom.hex
  end
end
