module TicketMaster::Provider
  module Codebase
    class Project < TicketMaster::Provider::Base::Project
      API = CodebaseAPI::Project
    end
  end
end
