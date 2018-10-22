module Thin
  class Response
    ACCESS_CONTROL = 'Access-Control-Allow-Origin'.freeze
    WILDCARD = '*'.freeze

    def headers_output
      # Set default headers
      @headers[CONNECTION] = persistent? ? KEEP_ALIVE : CLOSE unless @headers.has_key?(CONNECTION)
      @headers[SERVER] = Thin::NAME unless @headers.has_key?(SERVER)
      @headers[ACCESS_CONTROL] = WILDCARD

      @headers.to_s
    end
  end
end
