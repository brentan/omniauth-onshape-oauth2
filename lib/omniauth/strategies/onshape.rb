require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class onShape < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'onshape_dev'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => 'https://dev-portal.dev.onshape.com',
        :authorize_url => 'https://partner.dev.onshape.com/oauth/authorize',
        :token_url => 'https://partner.dev.onshape.com/oauth/token'
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
          :email => raw_info['email']
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      alias :oauth2_access_token :access_token

      #def access_token
      #  ::OAuth2::AccessToken.new(client, oauth2_access_token.token, {
      #    :mode => :query,
      #    :param_name => 'oauth2_access_token',
      #    :expires_in => oauth2_access_token.expires_in,
      #    :expires_at => oauth2_access_token.expires_at
      #  })
      #end

      def raw_info
        @raw_info ||= access_token.get("/v1/people/~:(#{option_fields.join(',')})?format=json").parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'onshape', 'onShape'