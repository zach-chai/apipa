require 'test_helper'

class AppTest < ApplicationTest
  def test_root
    get '/'
    assert last_response.ok?
    assert_equal 'application/vnd.api+json', last_response.headers['Content-Type']

    response_body = JSON.parse last_response.body
    response_body['jsonapi']['version'] = '1.0'
  end

  # Start GET /messages tests
  def test_list_messages
    get '/messages'
    assert last_response.ok?
    assert_equal 'application/vnd.api+json', last_response.headers['Content-Type']

    response_body = JSON.parse last_response.body
    data = response_body['data']

    data.each do |message|
      verify_message Message[message['id']], message
    end
  end

  def test_list_messages_palindrome_filtering
    get '/messages', filter: { is_palindrome: 'true' }

    response_body = JSON.parse last_response.body
    data = response_body['data']

    data.each do |message|
      assert_equal true, message.dig('attributes', 'is_palindrome')
    end
  end

  def test_list_messages_default_sorting
    get '/messages'

    response_body = JSON.parse last_response.body
    data = response_body['data']

    id_index = 0
    data.each do |message|
      assert id_index < message['id']
      id_index = message['id']
    end
  end

  def test_list_messages_palindrome_sorting
    get '/messages', sort: 'is_palindrome'

    response_body = JSON.parse last_response.body
    data = response_body['data']

    values = [true, false]
    data.each do |message|
      assert values.include? message.dig('attributes', 'is_palindrome')
      values = [true] if message.dig('attributes', 'is_palindrome')
    end
  end

  def test_list_messages_pagination_limit
    get '/messages', page: { limit: '1' }
    response_body = JSON.parse last_response.body
    data = response_body['data']

    unless data.empty?
      data.length.must_equal 1
    end
  end

  def test_list_messages_pagination_offset
    get '/messages', page: { offset: '1' }
    response_body = JSON.parse last_response.body
    data = response_body['data']

    unless data.empty?
      assert_equal Message.all[2].id, data[2]['id']
    end
  end
  # End GET /messages tests

  # Start GET /messages/:id tests
  def test_get_existing_message_id
    id = Message.all.first&.id
    return if id.nil?

    get "/messages/#{id}"
    assert last_response.ok?
    assert_equal 'application/vnd.api+json', last_response.headers['Content-Type']

    response_body = JSON.parse last_response.body
    data = response_body['data']

    verify_message Message[data['id']], data
  end

  def test_get_unavailable_message_id
    id = -1
    get "/messages/#{id}"
    assert last_response.not_found?
  end
  # End GET /messages/:id tests

  # Start POST /messages tests
  def test_create_palindrome_message
    body = {
    	data: {
    		type: 'messages',
    		attributes: {
    			content: 'racecar'
    		}
    	}
    }

    post '/messages', body.to_json, 'CONTENT_TYPE' => AppConstants::CONTENT_TYPE
    assert last_response.created?
    assert_equal 'application/vnd.api+json', last_response.headers['Content-Type']

    response_body = JSON.parse last_response.body
    data = response_body['data']

    assert_equal 'messages', data['type']
    assert_equal body[:data][:attributes][:content], data['attributes']['content']
    assert data['attributes']['is_palindrome']
    assert_equal "localhost:4567/messages/#{data['id']}", last_response.headers['Location']
  end

  def test_create_non_palindrome_message
    body = {
      data: {
    	  type: 'messages',
    	  attributes: { content: 'not palindrome' }
      }
    }

    post '/messages', body.to_json, 'CONTENT_TYPE' => AppConstants::CONTENT_TYPE
    assert last_response.created?

    response_body = JSON.parse last_response.body
    data = response_body['data']

    assert_equal 'messages', data['type']
    assert_equal body[:data][:attributes][:content], data['attributes']['content']
    assert_equal false, data['attributes']['is_palindrome']
  end

  def test_create_message_with_missing_content
    body = {
      data: {
        type: 'messages',
        attributes: {}
      }
    }

    post '/messages', body.to_json, 'CONTENT_TYPE' => AppConstants::CONTENT_TYPE
    assert last_response.unprocessable?
  end

  def test_invalid_content_type
    post '/messages', '{}', 'CONTENT_TYPE' => "#{AppConstants::CONTENT_TYPE}; version=2"
    assert_equal 415, last_response.status
  end

  def test_invalid_json_document
    post '/messages', 'invalid_doc', 'CONTENT_TYPE' => AppConstants::CONTENT_TYPE
    assert last_response.bad_request?
  end

  def test_empty_payload
    post '/messages', nil, 'CONTENT_TYPE' => AppConstants::CONTENT_TYPE
    assert last_response.unprocessable?
  end
  # End POST /messages tests

  # Start DELETE /messages tests
  def test_delete_existing_message_id
    content = 'test palindrome'
    message = Message.create content: content, is_palindrome: Palindrome.palindrome?(content).to_s

    delete "/messages/#{message.id}"
    assert last_response.no_content?
  end

  def test_delete_unavailable_message_id
    delete '/messages', id: -1
    assert last_response.not_found?
  end
  # End DELETE /messages tests

  # Message test helpers
  def verify_message(record, message_body)
    assert_equal 'messages', message_body['type']
    assert_equal record.id, message_body['id']
    assert_equal record.content, message_body['attributes']['content']
    assert_equal record.is_palindrome == 'true', message_body['attributes']['is_palindrome']
  end
end
