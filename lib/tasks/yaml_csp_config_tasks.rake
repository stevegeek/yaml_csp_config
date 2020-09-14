# frozen_string_literal: true

desc "Output the final CSP configuration in this environment"
namespace :yaml_csp_config do
  task view: :environment do
    YamlCspConfig.configure
    policy = ActionDispatch::ContentSecurityPolicy.new.load_from_yml
    puts "\nDirective\t\t: Directive Value"
    puts "---------\t\t  ---------------"
    policy.directives.each do |k, v|
      puts "#{k}\t\t: #{v.join(' ')}"
    end

    puts "\n\nConfiguration\t\t: Value"
    puts "-------------\t\t  -----"
    YamlCspConfig.configuration.instance_variables.each do |k|
      puts "#{k[1..]}\t\t: '#{YamlCspConfig.configuration.instance_variable_get(k)}'"
    end
  end
end
