require File.expand_path 'boot.rb', __dir__

set :bind, '0.0.0.0'
set :port, 4567

Sinatra::Application.run!
