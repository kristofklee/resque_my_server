#!/usr/bin/env ruby

require "rubygems"
require "resque"

#require "workers/ffmpeg_converter"
class FFmpegConverter
	@queue = :ffmpeg	
end

template = ARGV.shift
files = ARGV

files.each do |file|
	puts "\033[32mAdding:\033[0m #{file}"
	old_file = "#{File.expand_path(file)}"
	Resque.enqueue( FFmpegConverter, template, old_file )
end

