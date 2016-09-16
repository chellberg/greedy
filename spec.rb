require_relative 'greedy'
require 'minitest/autorun'

describe Greedy do
  before do
    @greedy = Greedy.new 'sample_data.txt'
  end

  it 'reads inputs correctly' do
    expected = %w(ATTAGACCTG CCTGCCGGAA AGACCTGCCG GCCGGAATAC)
    assert_equal @greedy.reads, expected
  end
end

