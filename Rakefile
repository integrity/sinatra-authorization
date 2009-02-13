require "rake/testtask"
require "rake/clean"

require File.dirname(__FILE__) + "/lib/sinatra/ditties"

task :default => :test

desc "Run tests"
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList["test/*_test.rb"]
end

directory "dist/"
CLOBBER.include("dist")

task :rdoc => FileList['lib/**/*.rb','README.rdoc'] do |t|
  sh <<-EOS
    hanna --charset utf8 \
          --fmt html \
          --inline-source \
          --line-numbers \
          --main README.rdoc \
          --op dist/doc \
          --title 'Sinatra Ditties Documentation' \
          #{t.prerequisites.join(" ")}
  EOS
end

desc 'Publish doc to rubyforge'
task 'publish:doc' => :rdoc do
  user = ENV["USER"] == "simon" ? "srt" : ENV["USER"]
  sh "scp -r dist/doc/* #{user}@rubyforge.org:/var/www/gforge-projects/sinatra-ditties/"
end
