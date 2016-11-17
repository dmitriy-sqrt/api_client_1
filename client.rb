require 'base64'

require 'rubygems'
require 'bundler/setup'
Bundler.require

module ApiClient
  class Base < JsonApiClient::Resource
    # set the api base url in an abstract base class
    self.site = "http://localhost:3000/api/"
  end

  class Branch < Base
  end

  class Branch::Landlord < Base
    belongs_to :branch
  end

  class Landlord < Base
  end

  class Landlord::Property < Base
    belongs_to :landlord
  end

  class Property < Base
  end

  class HeadersMiddleware < Faraday::Middleware
    APP_ID     = 'test'
    APP_SECRET = 'test'

    def call(environment)
      auth_hash = Base64.encode64("#{APP_ID}:#{APP_SECRET}")
      environment[:request_headers]["Accept"]         = 'application/json; version=1'
      environment[:request_headers]["Authorization"]  = "Basic #{auth_hash.strip}"
      @app.call(environment)
    end
  end
end

ApiClient::Base.connection do |connection|
  connection.use ApiClient::HeadersMiddleware
end

#puts ApiClient::Branch.all.inspect
#puts ApiClient::Landlord.where(branch_id: 363).all.inspect