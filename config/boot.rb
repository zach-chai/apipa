require 'bundler'
require 'sinatra/base'

Bundler.require(:default, Sinatra::Base.settings.environment)

# load lib
Dir[File.join(__dir__, '..', 'lib', '**', '*.rb')].each { |file| require file }

# load models
Dir[File.join(__dir__, '..', 'models', '*.rb')].each { |file| require file }

# load controllers
Dir[File.join(__dir__, '..', 'controllers', '*.rb')].each { |file| require file }

# load app
require File.join __dir__, '..', 'app.rb'

# load config
require File.join __dir__, 'initializer.rb'
