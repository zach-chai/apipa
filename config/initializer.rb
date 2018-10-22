App.set :public_url, ENV.fetch('PUBLIC_URL', 'localhost:4567')

Ohm.redis = Redic.new(ENV.fetch('REDIS_URL', 'redis://redis:6379'))
