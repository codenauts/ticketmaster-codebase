module TicketMaster::Provider
  module Codebase
    class Project < TicketMaster::Provider::Base::Project
      API = CodebaseAPI::Project

      def id
        permalink
      end
      
      def tickets(*options)
        begin
          if options.first.is_a? Hash
            super(*options)
          elsif options.empty?
            tickets = CodebaseAPI::Ticket.find(:all, :params => {:project => permalink}).collect { |ticket| TicketMaster::Provider::Codebase::Ticket.new ticket }
          else
            super(*options)
          end
        rescue
          []
        end
      end
      
      def ticket!(*options)
        options[0].merge!(:project => permalink) if options.first.is_a?(Hash)
        provider_parent(self.class)::Ticket.create(*options)
      end
    end
  end
end
