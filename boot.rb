require 'bundler'
require 'sinatra'

Bundler.require(:default, Sinatra::Base.settings.environment)

Ohm.redis = Redic.new(ENV['REDIS_URL'])

# load models
Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }

# load app file
require File.expand_path('../app.rb', __FILE__)
