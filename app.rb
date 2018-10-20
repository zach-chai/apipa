require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  'Hello world!'
end

get '/messages' do
  # TODO implement
end

get '/messages/:id' do
  # TODO implement
end

post '/messages' do
  # TODO implement
end
