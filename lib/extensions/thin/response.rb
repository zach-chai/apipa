module Thin
  class Response
    ACCESS_CONTROL_ORIGIN = 'Access-Control-Allow-Origin'.freeze
    ACCESS_CONTROL_METHODS = 'Access-Control-Allow-Methods'.freeze
    ACCESS_CONTROL_HEADERS = 'Access-Control-Allow-Headers'.freeze
    ALLOWED_METHODS = %w[OPTIONS GET POST].freeze
    WILDCARD = '*'.freeze

    def headers_output
      # Set default headers
      @headers[CONNECTION] = persistent? ? KEEP_ALIVE : CLOSE unless @headers.has_key?(CONNECTION)
      @headers[SERVER] = Thin::NAME unless @headers.has_key?(SERVER)

      # Allow CORS
      # This is for demonstration purposes only, not recommended in production
      @headers[ACCESS_CONTROL_ORIGIN] = WILDCARD
      @headers[ACCESS_CONTROL_METHODS] = ALLOWED_METHODS
      @headers[ACCESS_CONTROL_HEADERS] = WILDCARD
      @headers.to_s
    end
  end
end
