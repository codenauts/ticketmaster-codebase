module TicketMaster::Provider
  module Codebase
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = CodebaseAPI::Ticket
      
      def title
        self.summary
      end
      
      def comments(*options)
        begin
          if options.empty?
            comments = CodebaseAPI::Comment.find(:all, :params => {:project => prefix_options.project, :ticket_id => ticket_id}).collect { |comment| TicketMaster::Provider::Codebase::Comment.new comment }
          else
            super(*options)
          end
        rescue
         []
        end
      end
      
      def comment!(*options)
        options[0].merge!(:project => prefix_options.project) if options.first.is_a?(Hash)
        options[0].merge!(:ticket_id => ticket_id) if options.first.is_a?(Hash)
        puts options.inspect
        provider_parent(self.class)::Comment.create(*options)
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
