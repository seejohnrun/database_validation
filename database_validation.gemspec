require File.dirname(__FILE__) + '/lib/database_validation/version'

spec = Gem::Specification.new do |s|  
  s.name = 'database_validation'
  s.author = 'John Crepezzi'
  s.add_development_dependency('rspec')
  s.description = 'Automatically pull validations out of your database and apply them to your models'
  s.email = 'john.crepezzi@gmail.com'
  s.files = Dir['lib/**/*.rb']
  s.homepage = 'http://seejohnrun.github.com/database_validation/'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.summary = 'Automatic Rails validations from your database'
  s.test_files = Dir.glob('spec/*.rb')
  s.version = DatabaseValidation::version
  s.rubyforge_project = "database_validation"
end

