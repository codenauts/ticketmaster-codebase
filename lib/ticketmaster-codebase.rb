require File.dirname(__FILE__) + '/codebase/codebase-api'

%w{ codebase project }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
