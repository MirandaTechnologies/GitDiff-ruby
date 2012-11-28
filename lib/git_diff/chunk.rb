module GitDiff
	class Chunk
		attr_reader :lines

		def initialize(old, new)
			@old_range = old
			@new_range = new

			@lines = []
		end

		def insert(type, line)
			line = {
				:type => type, 
				:content => line}
			@lines << line
		end
	
	
	end
end
