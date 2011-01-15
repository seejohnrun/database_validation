require File.dirname(__FILE__) + '/../lib/database_validation'

ActiveRecord::Base.establish_connection(:adapter => 'mysql', :database => 'johnsql')

def execute(sql)
  ActiveRecord::Base.connection.execute(sql)
end
