# YamlCspConfig

`YamlCspConfig` extends `ActionDispatch::ContentSecurityPolicy` with a method to 
load configuration from a YAML file.

The CSP configuration can also be extended by environment variables.

## Usage

`TODO`


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'yaml_csp_config'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install yaml_csp_config
```

## Run type check (RBS & steep)

First copy the signatures for Rails from `https://github.com/pocke/rbs_rails/tree/master/assets/sig`
to the project `sig/rbs_rails` directory. Then run

    `bundle exec steep check`
    


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

