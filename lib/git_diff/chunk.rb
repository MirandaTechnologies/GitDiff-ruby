module GitDiff
class Chunk
		attr_reader :lines, :line_count

		def initialize(old, new)
			@old_range = old
			@new_range = new

			@lines = []
			@line_count = {
				:added 		=> 0,
				:removed 	=> 0,
				:unchanged 	=> 0}
			@old_number = @old_range.first
			@new_number = @new_range.first
		end

		def insert(type, line)
			line = {
				:number => {
					:old => '',
					:new => ''},
				:type => type, 
				:content => line}

			@line_count[type] += 1

			case type
			when :removed
				line[:number][:old] = @old_number
				@old_number += 1
			when :added
				line[:number][:new] = @new_number
				@new_number += 1
			when :unchanged
				line[:number][:old] = @old_number
				line[:number][:new] = @new_number
				@old_number += 1
				@new_number += 1
			end
				

			@lines << line
		end
	
	
	end
end
