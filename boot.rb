require 'bundler'
require 'sinatra'

Bundler.require(:default, Sinatra::Base.settings.environment)

# load config
Dir[File.join(__dir__, 'config', '*.rb')].each { |file| require file }

# load models
Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }

# load lib
Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |file| require file }

# load app file
require File.expand_path 'app.rb', __dir__
