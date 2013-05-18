module InlineManual
  class ApiRequest

    attr_accessor :path, :params, :method
    attr_reader :request, :response

    def initialize(path, params = {}, method = :get)
      @path = path
      @params = params
      @method = method
    end

    def url
      InlineManual.api_base + "/" + @path
    end

    # Returns JSON body of the response if request succeed.
    def send
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)

      if InlineManual.verify_ssl_certs
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http.ca_file = InlineManual.ssl_bundle_path
      end

      uri.query = @params.map{ |k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&') if @params.any?

      @request = Net::HTTP::Get.new(uri.request_uri, headers)
      @response = http.request(@request)

      handle_api_error(@response.code, @response.body) unless @response.is_a?(Net::HTTPSuccess)

      MultiJson.load(@response.body, :symbolize_names => true)
    rescue SocketError => e
      raise InlineManual::ApiConnectionError.new("Can't connect to #{uri.host}. Socket errors: #{e.message}.")
    rescue MultiJson::DecodeError
      raise InlineManual::ApiError.new("Invalid response object from API: #{@response.body.inspect} (HTTP response code was #{@response.code})", @response.code, @response.body)
    end

  protected

    def user_agent
      {
        :lib_version => InlineManual::VERSION,
        :lang => 'ruby',
        :lang_version => "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE})",
        :platform => RUBY_PLATFORM,
        :publisher => 'InlineManual',
        :uname => uname
      }
    end

    def headers
      headers = {
        'User-Agent' => "InlineManual/v1 RubyLib/#{InlineManual::VERSION}",
        #'Authorization' => "ApiKey #{api_key}",
        'Content-Type' => 'application/x-www-form-urlencoded',
        'X-InlineManual-Client-User-Agent' => MultiJson.dump(user_agent)
      }
      headers['Api-Version'] = InlineManual.api_version if InlineManual.api_version
      headers
    end

    def uname
      `uname -a 2>/dev/null`.strip if RUBY_PLATFORM =~ /linux|darwin/i
    rescue Errno::ENOMEM => ex # couldn't create subprocess
      "uname lookup failed"
    end

    def handle_api_error(code, body)
      error_obj = MultiJson.load(body, :symbolize_names => true)
      errors = error_obj[:errors] || raise_api_error(body, code)

      case code
      when 400, 404
        raise InlineManual::InvalidRequestError.new(errors[0], code,  body, error_obj)
      when 401, 402
        raise InlineManual::AuthenticationError.new(errors[0], code, body, error_obj)
      else
        raise InlineManual::ApiError.new(errors[0], code, body, error_obj)
      end
    rescue MultiJson::DecodeError
      raise_api_error(body, code)
    end

    def raise_api_error(body, code)
      raise InlineManual::ApiError.new("Invalid response object from API: #{body.inspect} (HTTP response code was #{code})", code, body)
    end

  end
end
