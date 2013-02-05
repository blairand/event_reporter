Gem::Specification.new do |s| 
  s.name         = "event_reporter"
  s.version      = "1.0.0"
  s.author       = "Blair Anderson"
  s.email        = "blair81@gmail.com"
  s.summary      = "something that does something"
  s.homepage     = "http://blairbuilds.herokuapp.com"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  
  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'event_reporter' ]
  
  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end
