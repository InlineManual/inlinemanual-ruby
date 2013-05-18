module InlineManual
  class SiteTopic < ApiResource

    def self.fetch_all
      retrieve("player/topics/")
    end

    def self.fetch(id)
      retrieve("player/topics/#{id}")
    end

    def self.api_key_name
      :site_key
    end

    def self.api_key_config
      :site_api_key
    end

  end
end
