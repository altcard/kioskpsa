#!/usr/bin/env ruby
require 'sinatra'
require 'haml'
require 'date'
require 'json'

$own_parent = File.join(File.dirname(__FILE__), '..')
require File.join($own_parent, 'commons.rb')

at_exit do
	settings = read_settings
	FileUtils.rm_rf(settings['output']);
end

get '/' do
	redirect '/record'
end

get '/record' do
	haml :recorder
end

post '/record' do
	settings = read_settings
	spath = File.join(settings['output'], "#{DateTime.now.to_time.to_i.to_s}.ogg")

	contents = request.body.read
	File.write(spath, contents)
end
