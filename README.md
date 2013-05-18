InlineManual - Ruby bindings
============================

*Warning: This gem is under heavy development!*

Official Ruby gem for the [Inline Manual API](https:://inlinemanual.com) with Rails integration.

## Compatibility:

Tested only with Ruby 1.9.2 and Rails 3.2.x

## Features:

* Fetch list of the site topics (tours).
* Fetch content of the topic.

## Installation

Add this line to your application's Gemfile:

    gem 'inlinemanual'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inlinemanual

## Usage

Example usage:

```ruby
require 'inlinemanual'

# For testing:
InlineManual.site_api_key = 'YOUR_SITE_API_KEY'

begin
  topics = InlineManual::SiteTopic::fetch_all
  topics.each do |t|
    puts InlineManual::SiteTopic::fetch(t[:id])
  end
rescue InlineManual::InlineManualError => e
  puts e.message
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure that your changes pass the tests (`bundle exec rake test`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Developed with love by fine folks of [Inline Manual](https://inlinemanual.com)

## License

The MIT License

Copyright © 2013- Inline Manual ([https://inlinemanual.com](https://inlinemanual.com))
