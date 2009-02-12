require "sinatra/base"

module Sinatra
  autoload :Authorization, File.dirname(__FILE__) + "/ditties/authorization"
  autoload :Mailer,        File.dirname(__FILE__) + "/ditties/mailer"
end
