require 'test_helper'

class IndexControllerTest < ApplicationTest
  def test_root
    get '/'
    assert last_response.ok?
    assert_equal 'application/vnd.api+json', last_response.headers['Content-Type']

    response_body = JSON.parse last_response.body
    response_body['jsonapi']['version'] = '1.0'
  end

  def app
    IndexController
  end
end
