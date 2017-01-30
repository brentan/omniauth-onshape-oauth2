# OmniAuth onShape OAuth2 Strategy

A onShape OAuth2 strategy for OmniAuth.

For more details, read the onShape documentation: (currently requires private API access to partner server)

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-onshape-oauth2'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-onshape-oauth2

## Usage

Register your application with onShape to receive an API key: https://dev-portal.dev.onshape.com

This is an example that you might put into a Rails initializer at `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :onshape, ENV['ONSHAPE_KEY'], ENV['ONSHAPE_SECRET']
end
```

You can now access the OmniAuth onShape OAuth2 URL: `/auth/onshape`.

Be sure to include the default callback URL in your onShape OAuth application settings: `/auth/onshape/callback`

## Partner Development Server

For testing, you can access the partner dev server, which has a different strategy, by passing the endpoint directly:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :onshape, ENV['ONSHAPE_KEY'], ENV['ONSHAPE_SECRET'],
    :setup => lambda{|env| 
      env['omniauth.strategy'].options[:client_options].site = 'https://partner.dev.onshape.com/api';
      env['omniauth.strategy'].options[:client_options].authorize_url = 'https://partner.dev.onshape.com/oauth/authorize';
      env['omniauth.strategy'].options[:client_options].token_url = 'https://partner.dev.onshape.com/oauth/token';
    }
end
```

## Granting Member Permissions to Your Application

With the onShape API, you have the ability to specify which permissions you want users to grant your application.

By default, omniauth-onshape-oauth2 requests the following permissions registered with your app:
OAuth2ReadPII,OAuth2Read

You can configure the scope option:

```ruby
provider :onshape, ENV['ONSHAPE_KEY'], ENV['ONSHAPE_SECRET'], :scope => 'OAuth2ReadPII,OAuth2Read...'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request