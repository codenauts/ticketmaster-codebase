module TicketMaster::Provider
  module Codebase
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = CodebaseAPI::Ticket
      
      def title
        self.summary
      end
      
      def self.create(*options)
        remote = API.new(*options)
        remote.save

        local = self.new remote
        local
      end
    end
  end
end
