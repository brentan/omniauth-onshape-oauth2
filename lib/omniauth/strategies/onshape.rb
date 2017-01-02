require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class OnShape < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'onshape'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => 'https://cad.onshape.com/api',
        :authorize_url => 'https://oauth.onshape.com/oauth/authorize',
        :token_url => 'https://oauth.onshape.com/oauth/token'
      } 

      # option :scope, 'r_basicprofile r_emailaddress'
      # option :fields, ['id', 'email-address', 'first-name', 'last-name', 'headline', 'location', 'industry', 'picture-url', 'public-profile-url']

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :firstName => raw_info['firstName'],
          :lastName => raw_info['lastName'],
          :email => raw_info['email'],
          :image => raw_info['image'],
          :url => raw_info['href'],
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||= access_token.get("users/sessioninfo").parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'onshape', 'OnShape'
