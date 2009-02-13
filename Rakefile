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

def package(ext='')
  "dist/sinatra-ditties-#{Sinatra::Ditties.version}" + ext
end

desc "Build packages"
task :package => %w[.gem .tar.gz].map {|e| package(e)}

desc "Build and install as local gem"
task :install => package(".gem") do
  sh "gem install #{package(".gem")}"
end

directory "dist/"

file package(".gem") => %w[dist/ sinatra-ditties.gemspec] do |f|
  sh "gem build sinatra-ditties.gemspec"
  mv File.basename(f.name), f.name
end

file package(".tar.gz") => %w[dist/] do |f|
  sh "git archive --format=tar HEAD | gzip > #{f.name}"
end

namespace :publish do
  task :release => [package(".gem"), package(".tar.gz")] do
  sh <<-EOS
    rubyforge add_release \
      sinatra-ditties sinatra-ditties #{Sinatra::Ditties.version} #{package('.gem')} &&
    rubyforge add_file    \
      sinatra-ditties sinatra-ditties #{Sinatra::Ditties.version} #{package('.tar.gz')}
  EOS
end

  desc 'Publish doc to rubyforge'
  task :doc => :rdoc do
    user = ENV["USER"] == "simon" ? "srt" : ENV["USER"]
    sh "scp -r dist/doc/* #{user}@rubyforge.org:/var/www/gforge-projects/sinatra-ditties/"
  end
end
