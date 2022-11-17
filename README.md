# `yaml_csp_config`: Rails content security policy configuration in YAML

### What?

A gem for Rails 6+ that allows you to specify your content security policy (CSP) in a YAML file, instead of using the Rails DSL. 


### Why?

The YAML configuration is potentially more structured, and easier to read and maintain
that using the Ruby DSL with conditional logic on env vars and so on.

Also config of the CSP becomes similar to configuring other things in Rails, such as the database, via YAML files. 

### Features

* Configure your CSP in YAML
  * Use anchors/aliases to avoid duplicated blocks of URLs between different policy directives
  * Create Rails env specific configurations (eg directives only for `development`)
* Extend the content security policy configuration via environment variables. Useful for deployed environments where the CSP is different per deployment.
  1) configure a specific addition for a specific directive or 
  2) specify the name of a group of configurations to be applied. 
* The YAML file can contain ERB

## Example

Below is an example of a security policy in YAML and Rails DSL.

### In YAML (with this gem):

`config/content_security_policy.yml`

```yaml
self_and_data_uri_policy: &SELF_AND_DATA
  - :self
  - :data

google_static_hosts: &GOOGLE_STATIC
  - https://*.googleapis.com
  - https://*.gstatic.com

content_security_policy:
  # Base config
  report_uri: "/csp-violation-report-endpoint"

  default_src: :self

  object_src: :none

  font_src: 
    - :self
    - *GOOGLE_STATIC
    - https://fonts.gstatic.com
  
  style_src: 
    - *SELF_AND_DATA
    - :unsafe_inline
  
  img_src:
    - *SELF_AND_DATA
    - *GOOGLE_STATIC
    - https://s3.amazonaws.com

  script_src:
    - :self
    - https://cdnjs.cloudflare.com
    - https://www.google-analytics.com
    - https://maps.googleapis.com

  connect_src:
    - :self

development:
  img_src:
    - http://localhost:3035

  script_src:
    - http://localhost:3035

  connect_src:
    - http://localhost:3035
    - ws://localhost:3000
    - ws://localhost:3035
    - ws://127.0.0.1:35729

review_apps:
  connect_src: 
    - wss://*.herokuapp.com
```

### Equivalent in Ruby DSL:

`config/initializers/content_security_policy.rb`

```ruby
GOOGLE_STATIC = ["https://*.googleapis.com", "https://*.gstatic.com"].freeze

CSP_SCRIPT_HOSTS = %w[
  https://cdnjs.cloudflare.com
  https://www.google-analytics.com
  https://maps.googleapis.com
].freeze

CSP_FONT_HOSTS = (["https://fonts.gstatic.com"] + GOOGLE_STATIC).freeze

CSP_IMAGE_HOSTS =  (["https://s3.amazonaws.com"] + GOOGLE_STATIC).freeze
  
CSP_WEBPACKER_HOST = "http://localhost:3035"

CSP_DEV_CONNECT_SRC = %w[
  http://localhost:3035
  ws://localhost:3000
  ws://localhost:3035
  ws://127.0.0.1:35729
].freeze

CSP_REVIEW_CONNECT_SRC = %w[
  wss://*.herokuapp.com
].freeze

Rails.application.config.content_security_policy do |policy|
  policy.report_uri("/csp-violation-report-endpoint")

  policy.default_src(:self)

  policy.object_src(:none)
    
  policy.font_src(:self, *CSP_FONT_HOSTS)
  
  policy.style_src(:self, :data, :unsafe_inline)

  if Rails.env.development?
    policy.img_src(:self, :data, CSP_WEBPACKER_HOST, *CSP_IMAGE_HOSTS)

    policy.script_src(:self, :unsafe_eval, CSP_WEBPACKER_HOST, *CSP_SCRIPT_HOSTS)
     
    policy.connect_src(:self, *CSP_DEV_CONNECT_SRC)
  else
    policy.img_src(:self, :data, *CSP_IMAGE_HOSTS)

    policy.script_src(:self, *CSP_SCRIPT_HOSTS)
  
    if ENV["IN_REVIEW_APP"].present?
      policy.connect_src(:self, *CSP_REVIEW_CONNECT_SRC)
    else
      policy.connect_src(:self)
    end
  end
end

# ...
```

## Installation
Add to your Gemfile:

```ruby
gem 'yaml_csp_config'
```

Or install it yourself as:
```bash
$ gem install yaml_csp_config
```
Then run the **generator to add the initializer**

    rails g yaml_csp_config:install


## Usage

### YAML file format

Note: The YAML file can also be an ERB template.

The file must contain at at least the 'base' configuration group, containing the base or common CSP 
configuration.

This key of this group by default is `content_security_policy` but can be configured via the `yaml_config_base_key`
config value in the initializer.

Directive configurations are then specified as keys named after the directive 
(see `YamlCspConfig::YamlLoader::DIRECTIVES` for a list)  and then either an array of  policy values, 
or a single value (note that if you use aliases you may end up creating nested arrays of values this 
is no problem as it will be flattened). Values can either be strings or symbols.

```yaml
# example
content_security_policy:
  object_src: :none
  connect_src:
    - :self
  font_src: *SELF_AND_DATA
  script_src:
    - :self
    - *GOOGLE
  img_src: "host"
```

The file can contain any number of other configuration groups. If the group is named after an environment of your Rails 
application it will be mixed in automatically if the application is running in that environment.

### Adding to configuration based on current Rails environment

A configuration group named after rails environment will be mixed in in that environment:

```yaml
# example
development:
  connect_src: "host.dev"
test:
  connect_src: "host.test"
```

### Adding a named configuration group using an environment variable

The name of the environment variable that can be set with the name of the group to add is by default 
`CSP_CONFIGURATION_GROUP_KEY`. It can be changed using the configuration variable `default_env_var_group_key` 
from the initializer.

 for example given the following environment variables set on the application's  environmentY

    CSP_CONFIGURATION_GROUP_KEY=staging_app

the following configuration group will be mixed in:

```yaml
# example
staging_app:
  connect_src: "host.staging"
```

### Adding to configuration based with environment variables

The CSP configuration can also be extended  directly by environment variables. The environment variable names are 
prefixed with a standard prefix. This prefix is by default `CSP_CONFIGURATION_ADDITIONS_`. It can be changed using 
the configuration variable `default_env_var_additions_key_prefix` from the initializer.

After the prefix comes the name of the directive in uppercase. The value of the environment variable will then be added
automatically to the configuration of that directive.
   
For example:

    CSP_CONFIGURATION_ADDITIONS_SCRIPT_SRC=host.cdn

will add `host.cdn` to the `script_src`  directive.

### Note this extends `ActionDispatch::ContentSecurityPolicy.load_from_file`

`YamlCspConfig` extends `ActionDispatch::ContentSecurityPolicy` with a method to
load configuration from a YAML file. By default the initializer will add the `load_from_file`
instance method and call it on initialisation.

If you wish instead to call it explicitly  make sure to comment it out from the initializer.

## Run type check (RBS & steep)

First copy the signatures for Rails from `https://github.com/pocke/rbs_rails/tree/master/assets/sig`
to the project `sig/rbs_rails` directory. Then run

    bundle exec steep check
    
## Run tests

     ./bin/test

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Contributing

Contributors welcome! Any contribution appreciated Pull requests, issues, and feature requests.

## Contributors

[Stephen Ierodiaconou](https://github.com/stevegeek/)
