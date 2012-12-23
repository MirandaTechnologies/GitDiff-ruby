require 'test/unit'
require 'git_diff'

class SingleFileTest < Test::Unit::TestCase

    def setup
        @diffs = GitDiff.parse_file('test/files/single_commit.patch')
        @readme = @diffs.files[0]
        @lines= @readme.chunks[0].lines
    end
    
    def test_new_filename
        assert_equal "README", @readme.new_filename 
    end

    def test_old_filename
        assert_equal "README", @readme.old_filename
    end

    def test_unchanged_lines
        lines = []
        lines << @lines[0][0]
        lines << @lines[1][0]
        lines << @lines[2][0]
        lines << @lines[5][0]
        lines << @lines[6][0]
        lines << @lines[7][0]
        lines << @lines[7][2]
        lines << @lines[8][0]
        lines << @lines[9][0]
        lines << @lines[10][0]
        lines << @lines[11][1]

        lines.each do |line|
            assert_equal :unchanged, line[:modif], "Not unchanged : '#{line[:content]}'"
        end
    end

    def test_removed_lines
        lines = []
        lines << @lines[3][0]
        lines << @lines[7][1]

        lines.each do |line|
            assert_equal :removed, line[:modif], "Not removed : '#{line[:content]}'"
        end
    end

    def test_added_lines
        lines = []
        lines << @lines[11][0]
        
        lines.each do |line|
            assert_equal :added, line[:modif], "Not added : '#{line[:content]}'"
        end
    end


end
