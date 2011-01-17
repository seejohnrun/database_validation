ENV["RAILS_ENV"] = "test"

require File.dirname(__FILE__) + "/../lib/database_validation"
require "rspec/rails/extensions"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

load File.dirname(__FILE__) + "/schema.rb"
%w[user person].each do |model|
  load File.dirname(__FILE__) + "/support/#{model}.rb"
end