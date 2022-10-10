# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.

if Gem.loaded_specs["activesupport"].version < Gem::Version.new("7.0.0")
  Rails.application.config.assets.version = "1.0"
end


# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
