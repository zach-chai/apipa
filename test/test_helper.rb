# test_helper.rb
ENV['RACK_ENV'] = 'test'

require File.expand_path '../../boot.rb', __FILE__

require 'minitest/autorun'
require 'rack/test'

class ApplicationTest < MiniTest::Spec
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
  end
end
