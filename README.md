# Apple::App::Site::Association

[![Build Status](https://travis-ci.org/toihrk/apple-app-site-association.svg?branch=master)](https://travis-ci.org/toihrk/apple-app-site-association)

A mountable Sinatra application for introduce the universal link to your application.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apple-app-site-association'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apple-app-site-association


## Usage

### in Rails

Generate file:

    $ bundle exec rails g universal_link:install

Configure:

```rb
# config/initializers/apple-app-site-association.rb

Apple::App::Site::Association.configure do |c|
  c.datails { appID: '9JA89QQLNQ.com.apple.wwdc', paths: ['/wwdc/news/', '/videos/wwdc/2015/*'] },
            { appID: 'ABCD1234.com.apple.wwdc', paths: '*' }
end
```

Mount:

```rb
# config/routes.rb

Rails.application.routes.draw do
  mount Apple::App::Site::Association, at: '/.well-known'
  # or
  # mount Apple::App::Site::Association, at: '/'
end

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [toihrk/apple-app-site-association](https://github.com/toihrk/apple-app-site-association). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
