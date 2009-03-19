task :default => :test

desc "Run tests"
task :test do
  ruby "test/authorization_test.rb"
end

begin
  require "mg"
  MG.new("sinatra-authorization.gemspec")
rescue LoadError
end
