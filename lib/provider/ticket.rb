module TicketMaster::Provider
  module Codebase
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = CodebaseAPI::Ticket

      def initialize(*object) 
        if object.first
          object = object.first
          @system_data = object

          unless object.is_a? Hash
            hash = {:id => object.ticket_id,
                    :title => object.summary,
                    :created_at => object.created_at,
                    :updated_at => object.updated_at}

          else
            hash = object
          end
          super hash
        end
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
        options[0].merge!(:ticket_id => id) if options.first.is_a?(Hash)
        provider_parent(self.class)::Comment.create(*options)
      end
      
      def self.create(*options)
        remote = API.new(*options)
        remote.save

        if remote.present?
          local = self.new(remote)
          local.prefix_options = remote.prefix_options
          local
        end
      end

      def self.find_by_id(project_id, id)
        remote = CodebaseAPI::Ticket.find(id, :params => {:project => project_id})

        if remote.present?
          local = self.new(remote) if remote.present?
          local.prefix_options = remote.prefix_options
          local
        end
      end
    end
  end
end
