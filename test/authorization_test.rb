require "test/unit"
require "rack/test"
require "context"
require "pending"

require File.dirname(__FILE__) + "/../lib/sinatra/authorization"

class AuthorizationApp < Sinatra::Default
  set :environment, :test

  get "/" do
    login_required

    "Welcome in protected zone"
  end

  def authorize(username, password)
    username == "user" && password = "test"
  end

  def authorization_realm
    "Move on"
  end
end

class SugarApp < Sinatra::Default
  set :environment, :test

  authorize 'The Sugar App' do |*credentials|
    credentials == ['fizz', 'buzz']
  end

  protecting %r|/sekret|

  get '/' do
    login_required
    'ok'
  end

  get '/ok' do
    'ok'
  end

  get '/sekret' do
    'ok'
  end
end

class SinatraAuthorizationTest < Test::Unit::TestCase
  before do
    @session = Rack::Test::Session.new(AuthorizationApp)
  end

  def basic_auth(user="user", password="test")
    credentials = ["#{user}:#{password}"].pack("m*")

    { "HTTP_AUTHORIZATION" => "Basic #{credentials}" }
  end

  it "is authorized with correct credentials" do
    @session.get "/", {}, basic_auth
    assert_equal 200, @session.last_response.status
    assert_equal ["Welcome in protected zone"], @session.last_response.body
  end

  it "sets REMOTE_USER" do
    pending "TODO"
  end

  it "is unauthorized without credentials" do
    @session.get "/"
    assert_equal 401, @session.last_response.status
  end

  it "is unauthorized with incorrect credentials" do
    @session.get "/", {}, basic_auth("evil", "wrong")
    assert_equal 401, @session.last_response.status
  end

  it "returns specified realm" do
    @session.get "/"
    assert_equal %Q(Basic realm="Move on"), @session.last_response["WWW-Authenticate"]
  end

  it "returns a 400, Bad Request if not basic auth" do
    @session.get "/", {}, { "HTTP_AUTHORIZATION" => "Foo bar" }
    assert_equal 400, @session.last_response.status
  end

  describe "sugarly" do
    before do
      @session = Rack::Test::Session.new(SugarApp)
    end

    it "generates #authorize method via DSL" do
      @session.get '/'
      assert_equal 401, @session.last_response.status

      @session.get '/', {}, basic_auth('fizz', 'buzz')
      assert_equal 200, @session.last_response.status
    end

    it "allows realm to be specified" do
      @session.get '/'
      assert_equal %Q(Basic realm="The Sugar App"), @session.last_response["WWW-Authenticate"]
    end

    it "allows protected actions to be specified" do
      @session.get '/ok'
      assert_equal 200, @session.last_response.status

      @session.get '/sekret'
      assert_equal 401, @session.last_response.status
    end
  end
end
