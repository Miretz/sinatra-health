require 'rubygems'
require 'bundler'

Bundler.require

require "sinatra-health.rb"

set :run, false
set :environment, :production

run Sinatra::Application