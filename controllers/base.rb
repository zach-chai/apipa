class Base < Sinatra::Application
  before do
    next unless %w[POST PUT PATCH].include? request.request_method

    request.body.rewind
    raw_request_body = request.body.read
    if raw_request_body.empty?
      @request_body = {}
      next
    end

    @request_body = begin
                      JSON.parse raw_request_body
                    rescue JSON::ParserError
                      halt 400
                    end

    # Check Content-Type for support
    halt 415 if request.media_type != AppConstants::CONTENT_TYPE || request.media_type_params.any?
  end

  before do
    next unless %w[GET POST].include? request.request_method
    content_type AppConstants::CONTENT_TYPE
  end
end
