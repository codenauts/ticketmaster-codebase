module TicketMaster::Provider
  module Codebase
    class Comment < TicketMaster::Provider::Base::Comment
      API = CodebaseAPI::Comment 

      def initialize(*object) 
        if object.first
          object = object.first
          @system_data = object

          unless object.is_a? Hash
            hash = {:id => object.id,
                    :content => object.content,
                    :created_at => object.created_at,
                    :updated_at => object.updated_at}

          else
            hash = object
          end
          super hash
        end
      end

      def self.create(*options)
        remote = API.new(*options)
        remote.save

        local = self.new remote
        local.prefix_options = remote.prefix_options
        local
      end
    end
  end
end