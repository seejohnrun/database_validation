require File.dirname(__FILE__) + "/lib/database_validation/version"

Gem::Specification.new do |s|
  s.name        = "database_validation"
  s.version     = DatabaseValidation::version
  s.platform    = Gem::Platform::RUBY
  s.author      = "John Crepezzi"
  s.email       = "john.crepezzi@gmail.com"
  s.homepage    = "http://seejohnrun.github.com/database_validation/"
  s.summary     = "Automatic Rails validations from your database"
  s.description = "Automatically pull validations out of your database and apply them to your models"

  s.rubyforge_project = "database_validation"

  s.files         = Dir["lib/**/*.rb"]
  s.test_files    = Dir.glob("spec/*.rb")
  s.require_paths = ["lib"]

  s.add_dependency "activerecord"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3-ruby"
end
