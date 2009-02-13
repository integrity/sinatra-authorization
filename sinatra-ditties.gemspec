Gem::Specification.new do |s|
  s.name     = 'sinatra-ditties'
  s.version  = '0.0.2'
  s.date     = '2008-11-10'
  s.summary  = 'A series of plugins and useful helpers for the Sinatra web framework'
  s.description = 'A series of plugins and useful helpers for the Sinatra web framework'
  s.homepage = 'http://github.com/foca/sinatra-ditties'
  s.email    = 'contacto@nicolassanguinetti.info'
  s.authors  = ['Nicolás Sanguinetti']
  s.has_rdoc = true
  s.files    = ['README.rdoc',
    'lib/sinatra/ditties.rb',
    'lib/sinatra/ditties/authorization.rb',
    'lib/sinatra/ditties/mailer.rb',
  ]
  s.add_dependency('sinatra', ['>= 0.3.2'])
  s.add_dependency('mailfactory', ['>= 1.4.0'])
  s.add_dependency('tlsmail')
  s.rubyforge_project = "sinatra-ditties"
end
