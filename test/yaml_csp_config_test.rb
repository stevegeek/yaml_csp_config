# frozen_string_literal: true

require "test_helper"

module YamlCspConfig
  class Test < ActiveSupport::TestCase
    SELF_POLICY = "'self'"
    DATA_PROTOCOL_POLICY = "data:"

    test "loads from default location" do
      YamlCspConfig.configure
      policy = ActionDispatch::ContentSecurityPolicy.new.load_from_yml
      assert_kind_of ActionDispatch::ContentSecurityPolicy, policy
      assert_includes policy.directives, "script-src"
      assert_equal [SELF_POLICY, "https://www.google-analytics.com"], policy.directives["script-src"]
      assert_equal [SELF_POLICY, DATA_PROTOCOL_POLICY], policy.directives["font-src"]
      assert_equal [SELF_POLICY, DATA_PROTOCOL_POLICY, "foobar"], policy.directives["img-src"]
    end

    test "loads Rails env configuration" do
      Rails.env = "development"
      YamlCspConfig.configure
      policy = ActionDispatch::ContentSecurityPolicy.new.load_from_yml
      Rails.env = "test"
      assert_kind_of ActionDispatch::ContentSecurityPolicy, policy
      assert_includes policy.directives, "script-src"
      assert_equal [SELF_POLICY, "https://www.google-analytics.com", "'unsafe-eval'", "https://localhost:3035"],
                   policy.directives["script-src"]
      assert_equal [SELF_POLICY, DATA_PROTOCOL_POLICY], policy.directives["font-src"]
    end

    test "allow additions by environment variable" do
      ENV["CSP_CONFIGURATION_ADDITIONS_SCRIPT_SRC"] = "test"
      YamlCspConfig.configure
      policy = ActionDispatch::ContentSecurityPolicy.new.load_from_yml
      ENV["CSP_CONFIGURATION_ADDITIONS_SCRIPT_SRC"] = nil
      assert_kind_of ActionDispatch::ContentSecurityPolicy, policy
      assert_includes policy.directives, "script-src"
      assert_equal [SELF_POLICY, "https://www.google-analytics.com", "test"], policy.directives["script-src"]
    end

    test "allow additions by environment specified group" do
      ENV["CSP_CONFIGURATION_GROUP_KEY"] = "demo_app"
      YamlCspConfig.configure
      policy = ActionDispatch::ContentSecurityPolicy.new.load_from_yml
      ENV["CSP_CONFIGURATION_GROUP_KEY"] = nil
      assert_kind_of ActionDispatch::ContentSecurityPolicy, policy
      assert_includes policy.directives, "script-src"
      assert_equal [SELF_POLICY, "https://www.google-analytics.com", "https://cdnjs.cloudflare.com"],
                   policy.directives["script-src"]
    end
  end
end
