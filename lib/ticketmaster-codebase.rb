require File.dirname(__FILE__) + '/codebase/codebase-api.rb'

%w{ codebase project ticket comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
