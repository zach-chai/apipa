get '/' do
  'Hello world!'
end

get '/messages' do
  messages = Message.all

  if params.dig('filter', 'is_palindrome')
    messages = messages.find is_palindrome: params.dig('filter', 'is_palindrome')
  end

  messages = messages.sort order: 'ASC', limit: [0, 10]
  yajl :messages, locals: { messages: messages }
end

get '/messages/:id' do
  message = Message[params[:id]]
  halt 404 if message.nil?
  yajl :message, locals: { message: message }
end

post '/messages' do
  request.body.rewind
  body = JSON.parse request.body.read
  content = body['data']['attributes']['content']

  message = Message.create content: content, is_palindrome: Palindrome.palindrome?(content).to_s

  status 201
  headers 'Location' => "#{ENV['HOST']}/messages/#{message.id}"
  yajl :message, locals: { message: message }
end

delete '/messages/:id' do
  message = Message[params[:id]]
  halt 404 if message.nil?
  message.delete
  status 204
end
