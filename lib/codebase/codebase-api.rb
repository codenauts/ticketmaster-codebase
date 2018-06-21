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
    self.site = "https://api3.codebasehq.com"
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

  class Comment < Base
    self.element_name = "ticket_note"
    self.site += '/:project/tickets/:ticket_id'
    
    def self.collection_name
      "notes"
    end
  end
end
