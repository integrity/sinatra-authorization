# Let's get all those diddies playing together
Dir[File.dirname(__FILE__) + "/diddies/*.rb"].each &method(:require)