set :bind, '0.0.0.0'
set :port, ENV.fetch('PORT', '4567')

Ohm.redis = Redic.new(ENV.fetch('REDIS_URL', 'redis://redis:6379'))
set :host, ENV.fetch('HOST', 'localhost:4567')
