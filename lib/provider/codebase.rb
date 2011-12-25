module TicketMaster::Provider
  module Codebase
    include TicketMaster::Provider::Base
    TICKET_API = Codebase::Ticket
    PROJECT_API = Codebase::Project
    
    def self.new(auth = {})
      TicketMaster.new(:codebase, auth)
    end
    
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      
      auth = @authentication
      if auth.username.blank? and auth.token.blank?
        raise "Please provide username and token"
      end
      ::CodebaseAPI.authenticate(auth.username, auth.token)
    end
  end
end
