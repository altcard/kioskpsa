#!/usr/bin/env ruby
own_parent = File.dirname(__FILE__)
require File.join(own_parent, 'commons.rb')

settings = read_settings
puts settings

if not File.directory?(settings['output']) then
	puts "Please start the frontend first."
	exit 1
end

File.write(settings['socket'], "UwU")

def playAndRemove(path)
	system('play', '-d', '-q', path)
	FileUtils.rm_f(path)
end

while File.exists? settings['socket']
	Dir.entries(settings['output']).each do |file|
		if not (file == '.' or file == '..') then
			path = File.join(settings['output'], file);

			playAndRemove(path)
		end
	end
end

puts "Goodbye"
