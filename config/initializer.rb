Base.set(:public_url, ENV.fetch('PUBLIC_URL') {
  if Base.settings.environment == 'production'
    ''
  else
    'localhost:4567'
  end
})

Ohm.redis = Redic.new(ENV.fetch('REDIS_URL', 'redis://redis:6379'))
