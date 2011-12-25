require 'rubygems'
require 'active_support'
require 'active_resource'

module CodebaseAPI
  class Error < StandardError; end
  class << self
    def authenticate(username, token)
      @username = username
      @password = token
      self::Base.user = username
      self::Base.password = token
    end

    def resources
      @resources ||= []
    end
  end
  
  class Base < ActiveResource::Base
    self.site = "http://api3.codebasehq.com"
    def self.inherited(base)
      CodebaseAPI.resources << base
      super
    end
  end

  class Project < Base
  end

  class Ticket < Base
    self.site += '/:project'
  end
end
