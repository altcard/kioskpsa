#!/usr/bin/env ruby
require 'fileutils'
require 'json'

def read_settings
	spath = File.join(File.dirname(__FILE__), 'config.json')
	settings = { "output" => "/var/tmp/kioskpsa",
		     "playInterval" => 3.0,
		     "socket" => "/tmp/trigger2.txt" }

	if File.exists? spath then
		settings.merge!(JSON.parse(File.read(spath)))
	end

	if not File.directory? settings['output'] then
		FileUtils.mkdir_p(settings['output'])
	end

	return settings
end

