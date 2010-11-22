class FFmpegConverter
	@queue = "ffmpeg"

  @templates = {
		"normal720p2channels" => {
			:options1 => "-vcodec libx264 -vpre normal -crf 20 -r 25 -threads 0 -s hd720 -sws_flags lanczos -acodec copy",
			:options2 => "-acodec copy -newaudio"
		},
		"default720p2ch" => {
			:options1 => "-vcodec libx264 -vpre default -crf 20 -r 25 -threads 0 -s hd720 -sws_flags lanczos -acodec copy",
			:options2 => "-acodec copy -newaudio"
		},
		"hq720p2ch" => {
			:options1 => "-vcodec libx264 -vpre hq -crf 18 -r 25 -threads 0 -s hd720 -sws_flags lanczos -acodec copy",
			:options2 => "-acodec copy -newaudio"
		},
		"max720p2ch" => {
			:options1 => "-vcodec libx264 -vpre max -crf 15 -r 25 -threads 0 -s hd720 -sws_flags lanczos -acodec copy",
			:options2 => "-acodec copy -newaudio"
		}

	}

	def self.perform( template, file )
		puts "\033[32mConverting:\033[0m #{file}"
		
		t = @templates[template]
		output_dir = "#{File.expand_path(File.dirname(file))}"
		new_file = "#{output_dir}/#{File.basename(file, File.extname(file))}.mkv"
		command = "ffmpeg -i \"%s\" %s \"%s\" %s" % [ file, t[:options1], new_file, t[:options2] ]
		
		output = %x( #{command} )
		raise "exit 1" if $?.exitstatus == 1

		puts "\033[32mFinished\033[0m"
		puts ""
	end
end
