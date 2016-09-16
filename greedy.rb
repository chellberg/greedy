class Greedy
  def initialize filename, minimum_overlap: 450
    @filename = filename
    @minimum_overlap = minimum_overlap
  end

  string = 'foobar'
  overlap_candidate = 'barbaz'

  def find_maximum_overlap
    best_overlap = 0
    left, right = nil, nil
    reads.permutation(2) do |string, overlap_candidate|
      overlap = overlap_length(string, overlap_candidate)
      if overlap && overlap > best_overlap
        best_overlap = overlap
        left, right = string, overlap_candidate
      end
    end

    return left, right, best_overlap
  end

  def overlap_length string, overlap_candidate
    # index at which to begin looking in string for the overlap_candidate substring
    match_index = 0
    while true
      # search string for the first minimum_overlap length substring of overlap_candidate
      match_index = string.index overlap_candidate[0..@minimum_overlap], match_index
      return nil if !match_index

      # check that the overlap_candidate starts with the remaining substring of a from the match index onward
      if overlap_candidate.start_with? string[match_index..-1]
        overlap_length = string.length - match_index
        return overlap_length
      end

      # substring match found in string, but the rest of string doesn't match the beginning of overlap_candidate
      match_index += 1
    end
  end

  def reads
    # drop 1 because the first element will be ""
    @reads ||= File.read(@filename)
                   .delete("\r\n")
                   .split(/>Rosalind_\d{4}/)
                   .drop(1)
  end
end
