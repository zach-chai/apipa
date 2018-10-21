# test_helper.rb
ENV['RACK_ENV'] = 'test'

require File.expand_path '../boot.rb', __dir__

require 'minitest/autorun'
require 'rack/test'

class ApplicationTest < MiniTest::Spec
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
