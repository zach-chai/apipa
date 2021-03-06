# test_helper.rb
ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require File.expand_path '../config/boot.rb', __dir__

require 'minitest/autorun'
require 'rack/test'

class ApplicationTest < MiniTest::Spec
  include Rack::Test::Methods

  def app
    raise 'Implement app method for test class'
  end
end
