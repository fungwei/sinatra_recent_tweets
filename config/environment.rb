# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'yaml'

require 'rack-flash'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

#set up twitter
require 'twitter'
credentials = YAML.load(File.open("config/credentials.yml"))
# TWITTER_CLIENT = Twitter::REST::Client.new do |config|
#   config.consumer_key        = credentials["twitter_consumer_key"]
#   config.consumer_secret     = credentials["twitter_consumer_secret"]
#   config.access_token        = credentials["twitter_access_token"]
#   config.access_token_secret = credentials["twitter_access_token_secret"]
# end

CONSUMER_KEY = credentials["twitter_consumer_key"]
CONSUMER_SECRET = credentials["twitter_consumer_secret"]
CALLBACK_URL = "http://local.fung.com:9393/oauth/callback"

require 'oauth'