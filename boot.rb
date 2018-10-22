require 'bundler'
require 'sinatra'

Bundler.require(:default, Sinatra::Base.settings.environment)

HOST = ENV.fetch('HOST', 'localhost:4567').freeze
Ohm.redis = Redic.new(ENV.fetch('REDIS_URL', 'redis://redis:6379'))

# load models
Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }

# load lib
Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |file| require file }

# load app file
require File.expand_path 'app.rb', __dir__
