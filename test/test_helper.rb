require "test/unit"
require "sinatra/test"

$:.unshift File.expand_path(File.dirname(__FILE__) + "/../lib")

class Test::Unit::TestCase
  include Sinatra::Test
end

class TestApp < Sinatra::Default
  set :environment, :test
  enable :raise_errors
end

##
# test/spec/mini
# http://pastie.caboo.se/158871
# chris@ozmm.org
#
def describe(*args, &block)
  return super unless (name = args.first) && block
  name = "#{name.gsub(/\W/, '')}Test"
  Object.send :const_set, name, Class.new(Test::Unit::TestCase)
  klass = Object.const_get(name)
  klass.class_eval do
    def self.it(name, &block)
      define_method("test_#{name.gsub(/\W/,'_').downcase}", &block)
    end
    def self.xit(*args) end
    def self.before(&block) define_method(:setup, &block)    end
    def self.after(&block)  define_method(:teardown, &block) end
  end
  klass.class_eval &block
end
