require 'uri'
require 'cgi'
require 'net/http'
require 'openssl'
require 'multi_json'

# Version
require_relative 'inline_manual/version'

# Errors
require_relative 'inline_manual/errors/inline_manual_error'
require_relative 'inline_manual/errors/api_error'
require_relative 'inline_manual/errors/api_connection_error'
require_relative 'inline_manual/errors/invalid_request_error'
require_relative 'inline_manual/errors/authentication_error'

# Resources
require_relative 'inline_manual/api_request'
require_relative 'inline_manual/api_resource'
require_relative 'inline_manual/site_topic'

module InlineManual
  @api_base = 'https://inlinemanual.com/api'
  @site_api_key = ''
  @user_api_key = ''
  @api_version = nil
  @ssl_bundle_path  = File.dirname(__FILE__) + '/data/GeoTrustGlobalCA.crt'
  @verify_ssl_certs = true

  class << self
    attr_accessor :site_api_key, :user_api_key, :api_base, :verify_ssl_certs, :api_version
    attr_reader :ssl_bundle_path
  end

  def self.api_url(url='')
    @api_base + url
  end

end
