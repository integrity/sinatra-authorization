# Let's get all those ditties playing together
Dir[File.dirname(__FILE__) + "/ditties/*.rb"].each &method(:require)
