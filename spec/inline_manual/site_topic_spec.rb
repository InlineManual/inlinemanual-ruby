# encoding: utf-8
require_relative '../spec_helper'
require_relative '../../lib/inlinemanual'

describe InlineManual::SiteTopic do

  describe '.fetch_all' do
    it 'exists' do
      InlineManual::SiteTopic.must_respond_to :fetch_all
    end

    it 'retrieve topics from player/topics/' do
      skip
    end
  end

  describe '.fetch' do
    it 'exists' do
      InlineManual::SiteTopic.must_respond_to :fetch
    end

    it 'retrieve topic from player/topics/{id}' do
      skip
    end
  end

  describe '.api_key_name' do
    it 'returns :site_key by default' do
      InlineManual::SiteTopic.api_key_name.must_equal :site_key
    end
  end

  describe '.api_key_config' do
    it 'returns :site_api_key by default' do
      InlineManual::SiteTopic.api_key_config.must_equal :site_api_key
    end
  end

end
