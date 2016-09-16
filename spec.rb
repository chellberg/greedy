require_relative 'greedy'
require 'minitest/autorun'

describe Greedy do
  before do
    @greedy = Greedy.new 'sample_data.txt', minimum_overlap: 3
  end

  describe '#reads' do
    it 'reads inputs correctly' do
      expected = %w(ATTAGACCTG CCTGCCGGAA AGACCTGCCG GCCGGAATAC)
      assert_equal expected, @greedy.reads
    end
  end

  describe '#overlap_length' do
    describe 'when the strings overlap at the first substring match' do
      it 'returns the position of the overlap' do
        string = 'foobarbaz'
        overlap_candidate = 'barbazfizz' # starting_index will be 3
        overlap_length = @greedy.overlap_length string, overlap_candidate

        assert_equal 6, overlap_length
      end
    end

    describe 'when the strings overlap at the second substring match' do
      it 'returns the position of the overlap' do
        string = 'barbizbarflies'
        overlap_candidate = 'barfliesrule'
        overlap_length = @greedy.overlap_length string, overlap_candidate

        assert_equal 8, overlap_length
      end
    end

    describe 'when there is no substring match' do
      it 'returns nil' do
        string = 'foobarbaz'
        overlap_candidate = 'fizzbizfudge'
        overlap_length = @greedy.overlap_length string, overlap_candidate

        assert overlap_length.nil?
      end
    end
  end

  describe '#find_maximum_overlap' do
    it 'returns the correct reads and the overlap length' do
      # maximum overlap is barbaz
      test_reads = %w(
        foobarbaz
        barbazbiz
        bizbopwam
      )

      @greedy.stub :reads, test_reads do
        left, right, best_overlap = @greedy.find_maximum_overlap
        assert_equal 'foobarbaz', left
        assert_equal 'barbazbiz', right
        assert_equal 6, best_overlap
      end
    end
  end
end
