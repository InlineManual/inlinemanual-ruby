module InlineManual
  class ApiResource

    def self.fetch_all
      raise NotImplementedError.new('ApiResource is an abstract class. You should perform actions on its subclasses (Site, Topic, etc.)')
    end

    def self.fetch(id)
      raise NotImplementedError.new('ApiResource is an abstract class. You should perform actions on its subclasses (Site, Topic, etc.)')
    end

    def self.api_key_name
      raise NotImplementedError.new('ApiResource is an abstract class. You should perform actions on its subclasses (Site, Topic, etc.)')
    end

    def self.api_key_config
      raise NotImplementedError.new('ApiResource is an abstract class. You should perform actions on its subclasses (Site, Topic, etc.)')
    end

    def self.api_key
      @@api_key ||= InlineManual.send(api_key_config)
    end

  protected

    def self.retrieve(path)
      check_api_key
      request = ApiRequest.new(path, authorization_params)
      request.deliver
    end

    def self.authorization_params
      { api_key_name => api_key }
    end

    def self.check_api_key
      unless api_key
        raise AuthenticationError.new('No API key provided. Set your API key using ' +
          '"InlineManual.' + api_key_config + ' = <API-KEY>". You can generate API keys from the InlineManual web interface. ' +
          'See https://inlinemanual.com/support for details, or email support@inlinemanual.com if you have any questions.')
      end
      if api_key =~ /\s/
        raise AuthenticationError.new('Your API key is invalid, as it contains whitespace. ' +
          'Please, double-check your API key configuration "InlineManual.' + api_key_name + ' = <API-KEY>". ' +
          'See https://inlinemanual.com/support for details, or email support@inlinemanual.com if you have any questions.)')
      end
    end
  end
end
