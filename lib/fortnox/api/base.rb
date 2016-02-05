require 'fortnox/api/class_methods'
require 'fortnox/api/input_validation'
require 'fortnox/api/request_handling'
require 'httparty'

module Fortnox
  module API
    class Base

      include HTTParty
      extend Fortnox::API::ClassMethods
      include Fortnox::API::InputValidation
      include Fortnox::API::RequestHandling

      HTTParty::Parser::SupportedFormats[ "text/html" ] = :json

      DEFAULT_HEADERS = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
      }

      HTTP_METHODS = [ :get, :put, :post, :delete ]

      attr_accessor :headers

      def initialize( base_url: nil, client_secret: nil, access_token: nil )
        base_url = validate_base_url( base_url )
        client_secret = validate_client_secret( client_secret )
        access_token = validate_access_token( access_token )

        self.class.base_uri( base_url )

        self.headers = DEFAULT_HEADERS.merge({
          'Client-Secret' => client_secret,
          'Access-Token' => access_token,
        })
      end

      HTTP_METHODS.each do |method|
        define_method method do |*args|
          execute do |remote|
            remote.send( method, *args )
          end
        end
      end

    end
  end
end
