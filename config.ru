require File.expand_path 'boot.rb', __dir__

set :bind, '0.0.0.0'
set :port, ENV.fetch('PORT', '4567')

Sinatra::Application.run!
