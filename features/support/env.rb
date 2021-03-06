ENV['RACK_ENV'] = 'test'
require 'rubygems'
require 'sinatra'
require 'dm-core'
require File.join(File.dirname(__FILE__), '..', '..', 'models', 'model.rb')
# Generated by cucumber-sinatra. (Sat Mar 19 20:31:00 +0100 2011)
app_file = File.join(File.dirname(__FILE__), '..', '..', 'app.rb')
require app_file

require 'capybara'
require 'capybara/cucumber'
require 'rspec/expectations'
require 'rack/test'

Capybara.app = KrokenSlide

class KrokenSlideWorld
	include Rack::Test::Methods
  include Capybara
  include RSpec::Expectations
  include RSpec::Matchers
	def app
		Sinatra::Application
	end
end

World do
  KrokenSlideWorld.new
end
