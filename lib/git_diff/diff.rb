module GitDiff
	class Diff
		attr_reader :files 

		DIFF_HEADER			= /diff --git (.*)/

		COMMIT_PATTERN		= /index\s+([\da-f]+)..([\da-f]+)\s+(\d+)/
	
		OLD_FILE_PATTERN 	= /---\s+a\/(.*)/
		NEW_FILE_PATTERN 	= /\+\+\+\s+b\/(.*)/		
	
		CHUNK_PATTERN		= /^@@\s+-(\d+)(?:,(\d+))?\s+\+(\d+)(?:,(\d+))?\s+@@/
		CHUNK_REMOVED_LINE	= /^-(.*)/
		CHUNK_ADDED_LINE	= /^\+(.*)/
		CHUNK_UNCHANGED_LINE 	= /^\s(.*)/
	
	
		def initialize(diff)
			@diff = diff
			@files = []
			parse
		end

		private
			def parse
				
				@diff.each_line do |line|
					case line
					when DIFF_HEADER
						@files << @working_file unless @working_chunk.nil?
						# Do nothing
					when COMMIT_PATTERN
						@working_file = DiffFile.new($1,$2,$3) 
					when OLD_FILE_PATTERN
						@working_file.old_filename = $1
					when NEW_FILE_PATTERN
						@working_file.new_filename = $1
					when CHUNK_PATTERN
						@working_chunk = Chunk.new(($1.to_i..$1.to_i+$2.to_i),($3.to_i..$3.to_i+$4.to_i))
						@working_file.chunks << @working_chunk
					when CHUNK_REMOVED_LINE
						@working_chunk.insert(:removed,$1)
					when CHUNK_ADDED_LINE
						@working_chunk.insert(:added,$1)
					when CHUNK_UNCHANGED_LINE
						@working_chunk.insert(:unchanged,$1)
					else
						puts "Unknown"
					end
				end

				@files << @working_file unless @working_chunk.nil?

		end
	
	end  
end
