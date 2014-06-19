# encoding: utf-8
require_relative './spec_helper'
require_relative '../lib/inlinemanual'

# See https://github.com/stripe/stripe-ruby/blob/master/test/test_stripe.rb

describe InlineManual, 'module' do
  describe '.site_api_key' do
    it 'exists' do
      InlineManual.must_respond_to :site_api_key
    end
  end

  describe '.user_api_key' do
    it 'exists' do
      InlineManual.must_respond_to :user_api_key
    end
  end

  describe '.api_base' do
    it 'exists' do
      InlineManual.must_respond_to :api_base
    end
  end

  describe '.verify_ssl_certs' do
    it 'exists' do
      InlineManual.must_respond_to :verify_ssl_certs
    end
  end

  describe '.api_version' do
    it 'exists' do
      InlineManual.must_respond_to :api_version
    end
  end

  describe '.ssl_bundle_path' do
    it 'exists' do
      InlineManual.must_respond_to :ssl_bundle_path
    end
  end

  describe '.api_url' do
    it 'exists' do
      InlineManual.must_respond_to :api_url
    end
  end
end
