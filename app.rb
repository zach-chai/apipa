get '/' do
  'Hello world!'
end

get '/messages' do
  messages = Message.all

  if params.dig('filter', 'is_palindrome')
    messages = messages.find is_palindrome: params.dig('filter', 'is_palindrome')
  end

  # sort and paginate messages
  messages = sort_and_paginate(messages, params)

  yajl :messages, locals: { messages: messages }
end

get '/messages/:id' do
  message = Message[params[:id]]
  halt 404 if message.nil?
  yajl :message, locals: { message: message }
end

post '/messages' do
  request.body.rewind
  body = JSON.parse body request.body.read rescue nil
  halt 422 unless body.is_a? Hash

  content = body.dig('data', 'attributes', 'content')
  halt 422 if content.nil?

  message = Message.create content: content, is_palindrome: Palindrome.palindrome?(content).to_s

  status 201
  headers 'Location' => "#{HOST}/messages/#{message.id}"
  yajl :message, locals: { message: message }
end

delete '/messages/:id' do
  message = Message[params[:id]]
  halt 404 if message.nil?
  message.delete
  status 204
end

def sort_and_paginate(messages, params)
  sort, direction = SortParams.new(Message::SORT_ATTRIBUTES)
                              .process(params['sort'])
                              .values_at(:sort_by, :direction)
  if sort == SortParams::DEFAULT_SORT
    opts = { order: direction, limit: Pagination.process_offset(params['page']) }
    messages.sort opts
  else
    opts = { order: "ALPHA #{direction}", limit: Pagination.process_offset(params['page']) }
    messages.sort_by sort, opts
  end
end
