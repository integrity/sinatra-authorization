Gem::Specification.new do |s|
  s.name     = 'sinatra-diddies'
  s.version  = '0.0.1'
  s.date     = '2008-11-10'
  s.summary  = 'A series of plugins and useful helpers for the Sinatra web framework'
  s.description = 'A series of plugins and useful helpers for the Sinatra web framework'
  s.homepage = 'http://github.com/foca/sinatra-diddies'
  s.email    = 'contacto@nicolassanguinetti.info'
  s.authors  = ['Nicolás Sanguinetti']
  s.has_rdoc = false
  s.files    = ['README.markdown',
    'lib/diddies.rb',
    'lib/diddies/authorization.rb',
    'lib/diddies/mailer.rb',
  ]
  s.add_dependency('sinatra', ['>= 0.3.2'])
  s.add_dependency('mailfactory', ['>= 1.4.0'])
end
