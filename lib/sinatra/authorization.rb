require "sinatra/base"

module Sinatra
  # HTTP Authorization helpers for Sinatra.
  #
  # In your helpers module, include Sinatra::Authorization and then define
  # an #authorize(user, password) method to handle user provided
  # credentials.
  #
  # Inside your events, call #login_required to trigger the HTTP
  # Authorization window to pop up in the browser.
  #
  # Code adapted from {Ryan Tomayko}[http://tomayko.com/about] and
  # {Christopher Schneid}[http://gittr.com], shared under an MIT License
  module Authorization
    module Helpers
      # Redefine this method on your helpers block to actually contain
      # your authorization logic.
      def authorize(username, password)
        false
      end

      # From you app, call set :authorization_realm, "my app" to set this
      # or define a #authorization_realm method in your helpers block.
      def authorization_realm
        Sinatra::Default.authorization_realm
      end

      # Call in any event that requires authentication
      def login_required
        return if authorized?
        unauthorized! unless auth.provided?
        bad_request!  unless auth.basic?
        unauthorized! unless authorize(*auth.credentials)
        request.env['REMOTE_USER'] = auth.username
      end

      # Convenience method to determine if a user is logged in
      def authorized?
        !!request.env['REMOTE_USER']
      end
      alias :logged_in? :authorized?

      # Name provided by the current user to log in
      def current_user
        request.env['REMOTE_USER']
      end

      private
        def auth
          @auth ||= Rack::Auth::Basic::Request.new(request.env)
        end

        def unauthorized!(realm=authorization_realm)
          response["WWW-Authenticate"] = %(Basic realm="#{realm}")
          throw :halt, [ 401, 'Authorization Required' ]
        end

        def bad_request!
          throw :halt, [ 400, 'Bad Request' ]
        end
    end

    module DSL
      def protecting(*patterns)
        @protected_routes = []
        @protected_routes += patterns
      end

      def protecting?(path)
        @protected_routes && @protected_routes.any? { |pattern| path =~ pattern }
      end

      def authorize(realm="app", &block)
        set :authorization_realm, realm
        define_method(:authorize, &block)
      end
    end

    def self.registered(app)
      Sinatra.register(DSL)
      app.helpers Helpers

      app.before do
        login_required if self.class.protecting?(request.path_info)
      end
    end
  end

  register Authorization
end
