module TicketMaster::Provider
  module Codebase
    class Comment < TicketMaster::Provider::Base::Comment
      API = CodebaseAPI::Comment 
      
      def self.create(*options)
        remote = API.new(*options)
        remote.save

        local = self.new remote
        local
      end
    end
  end
end