require File.dirname(__FILE__) + "/test_helper"
require "sinatra/ditties"

class AuthorizationApp < TestApp
  include Sinatra::Authorization

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

describe "Authorization" do
  before do
    @session = Sinatra::TestHarness.new(AuthorizationApp)
  end

  def basic_auth(user="user", password="test")
    credentials = ["#{user}:#{password}"].pack("m*")

    { "HTTP_AUTHORIZATION" => "Basic #{credentials}" }
  end

  it "is authorized with correct credentials" do
    @session.get "/", :env => basic_auth
    assert_equal 200, @session.status
    assert_equal "Welcome in protected zone", @session.body
  end

  xit "sets REMOTE_USER" do
    flunk "pending"
  end

  it "is unauthorized without credentials" do
    @session.get "/"
    assert_equal 401, @session.status
  end

  it "is unauthorized with incorrect credentials" do
    @session.get "/", :env => basic_auth("evil", "wrong")
    assert_equal 401, @session.status
  end

  it "returns specified realm" do
    @session.get "/"
    assert_equal %Q(Basic realm="Move on"), @session["WWW-Authenticate"]
  end

  it "returns a 400, Bad Request if not basic auth" do
    @session.get "/", :env => { "HTTP_AUTHORIZATION" => "Foo bar" }
    assert_equal 400, @session.status
  end
end
