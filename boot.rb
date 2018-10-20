require 'bundler'
require 'sinatra'

Bundler.require(:default, Sinatra::Base.settings.environment)

set :bind, '0.0.0.0'
set :port, 4567
Ohm.redis = Redic.new(ENV['REDIS_URL'])

# load app file
require File.expand_path('../app.rb', __FILE__)
