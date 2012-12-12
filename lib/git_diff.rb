module GitDiff
	def self.parse(diff)
		GitDiff::Diff.new(diff)
	end

	def self.parse_file(filename)
		file = File.open(filename)
		diff = GitDiff::Diff.new(file.read)
		file.close
		diff
	end

	def self.from_bare(path, oldrev, newrev)
		cmd = "git diff-tree -p --find-copies-harder #{oldrev}..#{newrev}"
		puts cmd
		diff = `cd #{path} && #{cmd}`
		puts diff
		GitDiff::Diff.new(diff)
	end
end

require 'git_diff/diff'
require 'git_diff/chunk'
require 'git_diff/diff_file'
