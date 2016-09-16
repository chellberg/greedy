require 'minitest/autorun'
require_relative 'greedy'

class GreedyRealDataTest < Minitest::Test
  def setup
    @filename = 'real_data.txt'
    @greedy = Greedy.new(@filename, minimum_overlap: 450)
  end

  def test_that_superstring_contains_all_reads
    reads = @greedy.reads
    superstring = @greedy.shortest_common_superstring

    assert reads.all? { |read| superstring.include? read }
  end

  def test_superstring_length_is_consistent_with_varying_min_overlaps
    superstring_450 = @greedy.shortest_common_superstring
    superstring_400 = Greedy.new(@filename, minimum_overlap: 400).shortest_common_superstring
    superstring_300 = Greedy.new(@filename, minimum_overlap: 300).shortest_common_superstring

    length = superstring_450.length
    assert_equal length, superstring_400.length
    assert_equal length, superstring_300.length
  end
end
