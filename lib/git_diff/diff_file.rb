module GitDiff
	class DiffFile
		attr_accessor :new_filename, :old_filename, :chunks
		def initialize(from_commit, to_commit, mode)
			@from_commit 	= from_commit
			@to_commit 	= to_commit
			@mode		= mode

			@chunks = []
			@new_filename = ''
			@old_filename = ''
		end
		
		def added_lines_count
			count = 0
			@chunks.each do |chunk|
				count += chunk.added_lines_count
			end
		end
	end
end
