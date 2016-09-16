require_relative 'greedy'
require 'minitest/autorun'

describe Greedy do
  before do
    @greedy = Greedy.new 'sample_data.txt', minimum_overlap: 3

    # maximum overlap is barbaz
    @mergable_reads = %w(
      foobarbaz
      barbazbiz
      bizbopwam
    )
  end

  def stub_reads test_reads
    @greedy.stub :reads, test_reads do
      yield
    end
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
      stub_reads @mergable_reads do
        left, right, best_overlap = @greedy.find_maximum_overlap
        assert_equal 'foobarbaz', left
        assert_equal 'barbazbiz', right
        assert_equal 6, best_overlap
      end
    end
  end

  describe '#merge_best_overlap' do
    it 'merges the best overlap' do
      stub_reads @mergable_reads do
        @greedy.merge_best_overlap

        expected = %w(foobarbazbiz bizbopwam)
        assert_equal expected.sort, @greedy.reads.sort
      end
    end
  end

  describe '#shortest_common_superstring' do
    it 'returns a valid superstring' do
      superstring = @greedy.shortest_common_superstring
      assert_equal 'ATTAGACCTGCCGGAATAC', superstring
    end

    it 'concatenates unmergable reads' do
      unmergable_reads = %w(
        foobar
        bizbaz
      )

      stub_reads unmergable_reads do
        assert_equal 'foobarbizbaz', @greedy.shortest_common_superstring
      end
    end
  end

  describe '#merge_best_overlap_until_no_overlaps_remain' do
    it 'merges overlaps and leaves unmergable reads' do
      semimergable_reads = %w(
        foobar
        barbaz
        ucantmergedis
      )

      stub_reads semimergable_reads do
        expected = %w(
          foobarbaz
          ucantmergedis
        )

        @greedy.merge_best_overlap_until_no_overlaps_remain
        assert_equal expected.sort, @greedy.reads.sort
      end
    end
  end
end
