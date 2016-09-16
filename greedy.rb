class Greedy
  def initialize filename
    @filename = filename
  end

  def reads
    # drop 1 because the first element will be ""
    @reads ||= File.read(@filename).delete("\r\n").split(/>Rosalind_\d{4}/).drop(1)
  end
end
