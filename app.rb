get '/' do
  'Hello world!'
end

get '/messages' do
  messages = Message.all.sort order: 'ASC', limit: [0, 10]
  yajl :messages, locals: { messages: messages }
end

get '/messages/:id' do
  message = Message[params[:id]]
  if message
    yajl :message, locals: { message: message }
  else
    halt 404
  end
end

post '/messages' do
  request.body.rewind
  data = JSON.parse request.body.read
  content = data['content']

  message = Message.create content: content

  status 201
  yajl :message, locals: { message: message }
end
