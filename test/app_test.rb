require 'test_helper'

class AppTest < ApplicationTest

  # GET /messages/:id tests
  def test_get_existing_message_id
    id = 1
    get "/messages/#{id}"
    assert last_response.ok?

    response_body = JSON.parse last_response.body
    data = response_body['data']

    verify_message Message[data['id']], data
  end

  def test_get_unavailable_message_id
    id = -1
    get "/messages/#{id}"
    assert last_response.not_found?
  end

  # GET /messages tests
  def test_list_messages
    get '/messages'
    assert last_response.ok?

    response_body = JSON.parse last_response.body
    data = response_body['data']

    data.each do |message|
      verify_message Message[message['id']], message
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

  # POST /messages tests
  def test_create_palindrome_message
    body = {
    	data: {
    		type: 'messages',
    		attributes: {
    			content: 'racecar'
    		}
    	}
    }

    post '/messages', body.to_json, 'CONTENT_TYPE' => 'application/json'
    assert last_response.created?

    response_body = JSON.parse last_response.body
    data = response_body['data']

    assert_equal 'messages', data['type']
    assert_equal body[:data][:attributes][:content], data['attributes']['content']
    assert data['attributes']['is_palindrome']
  end

  def test_create_non_palindrome_message
    body = {
    	data: {
    		type: 'messages',
    		attributes: {
    			content: 'not palindrome'
    		}
    	}
    }

    post '/messages', body.to_json, 'CONTENT_TYPE' => 'application/json'
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

    post '/messages', body.to_json, 'CONTENT_TYPE' => 'application/json'
    assert last_response.unprocessable?
  end

  def verify_message record, message_body
    assert_equal 'messages', message_body['type']
    assert_equal record.id, message_body['id']
    assert_equal record.content, message_body['attributes']['content']
    assert_equal record.is_palindrome == 'true', message_body['attributes']['is_palindrome']
  end
end
