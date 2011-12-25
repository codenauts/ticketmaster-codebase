require 'rubygems'
require 'active_support'
require 'active_resource'

module CodebaseAPI
  class Error < StandardError; end
  class << self
    def authenticate(username, password)
      @username = username
      @password = password
      self::Base.user = username
      self::Base.password = password
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
    self.site += '/:project_id/tickets'
  end
end
