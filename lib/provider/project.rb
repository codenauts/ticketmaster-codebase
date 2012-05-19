module TicketMaster::Provider
  module Codebase
    class Project < TicketMaster::Provider::Base::Project
      API = CodebaseAPI::Project

      def initialize(*object) 
        if object.first
          object = object.first
          unless object.is_a? Hash
            hash = {
              :id => object.permalink,
              :name => object.name
            }
          else
            hash = object
          end
          super hash
        end
      end

      def tickets(*options)
        begin
          if options.first.is_a? Hash
            super(*options)
          elsif options.empty?
            tickets = CodebaseAPI::Ticket.find(:all, :params => {:project => id}).collect { |ticket| TicketMaster::Provider::Codebase::Ticket.new ticket }
          else
            super(*options)
          end
        rescue
          []
        end
      end
      
      def ticket!(*options)
        options[0].merge!(:project => id) if options.first.is_a?(Hash)
        provider_parent(self.class)::Ticket.create(*options)
      end
    end
  end
end
