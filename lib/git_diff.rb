module GitDiff
	def self.parse(diff)
		GitDiff::Diff.new(diff)
	end

	def self.parse_file(filename)
		file = File.open(filename)
		GitDiff::Diff.new(file.read)
		file.close
	end
end

require 'git_diff/diff'
require 'git_diff/chunk'
require 'git_diff/diff_file'
