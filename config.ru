require File.expand_path('../boot.rb', __FILE__)

set :bind, '0.0.0.0'
set :port, 4567

Sinatra::Application.run!
