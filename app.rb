# List stored messages
get '/messages' do
  messages = Message.all

  # Filter messages
  if params.dig('filter', 'is_palindrome')
    messages = messages.find is_palindrome: params.dig('filter', 'is_palindrome')
  end

  # sort and paginate messages
  sort, direction = SortParams.new(Message::SORT_ATTRIBUTES)
                              .process(params['sort'])
                              .values_at(:sort_by, :direction)
  messages = messages.sort_and_paginate sort,
                                        direction,
                                        Pagination.process_offset(params['page'])

  yajl :messages, locals: { messages: messages }
end

# Get message by ID
get '/messages/:id' do
  yajl :message, locals: { message: @message }
end

# Create message
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

# Delete message by ID
delete '/messages/:id' do
  @message.delete
  status 204
end

before '/messages/:id' do
  @message = Message[params[:id]]
  halt 404 if @message.nil?
end
