# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Lbdevelopmentv03::Application

require 'resque/server'

run Rack::URLMap.new(
    "/" => Rails.application,
    "/resque" => Resque::Server.new
)