Gem::Specification.new do |s|
  s.name     = "sinatra-authorization"
  s.rubyforge_project = "integrity"
  s.version  = "1.0.0"
  s.date     = "2009-04-19"
  s.summary  = "HTTP Authorization helpers for Sinatra."
  s.description  = "HTTP Authorization helpers for Sinatra."
  s.homepage = "http://github.com/integrity/sinatra-authorization"
  s.email    = "info@integrityapp.com"
  s.authors  = ["Nicolás Sanguinetti", "Simon Rozet"]
  s.has_rdoc = false
  s.files    = %w[
README.rdoc
Rakefile
sinatra-authorization.gemspec
lib/sinatra/authorization.rb
test/authorization_test.rb
]
  s.add_dependency("sinatra", [">= 0.9.1.1"])
end
