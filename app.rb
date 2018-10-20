get '/' do
  'Hello world!'
end

get '/messages' do
  messages = Message.all.sort order: 'ASC', limit: [0, 10]
  messages.map(&:to_json)
end

get '/messages/:id' do
  message = Message[params[:id]]
  message.to_json
end

post '/messages' do
  request.body.rewind # Maybe not required
  data = JSON.parse request.body.read

  message = Message.create content: content

  status 201
  message.to_json
end
