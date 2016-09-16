# chromosome assembly challenge


####[View the challenge text](https://github.com/chellberg/greedy/blob/master/problem.md) 
## Approach
### The De Bruijn saga

After reading through the problem, I googled "dna sequence assembly" and spent some time reading about the domain, starting with the [sequence assembly wikipedia article](https://en.wikipedia.org/wiki/Sequence_assembly). I read about the greedy algorithm, which sounded like how I'd naively approach the problem, but I quickly fixated on approaches using a De Bruijn graph because (my thinking at the time):

 - the greedy algorithm has "greedy" in the name, so it's clearly the naive, unoptimized solution
 - my goal here is to impress, so I want to implement a maximally optimal solution
 - De Bruijn graph approaches are superior to other approaches in every way!
   - [Finding the true path through a simple overlap graph is NP-hard](http://www.ncbi.nlm.nih.gov/pubmed/27587667)
   - the greedy algorithm doesn't necessarily produce the optimal solution
   - De Bruijn assemblers are [how the cool bio kids do next-generation sequence assembly](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2874646/) and [Driver](http://drivergrp.com) seems pretty cutting edge, so this is probably what they want.

Anyway, I found what looked like a [reasonable Python implementation](https://gist.github.com/BenLangmead/5298132) and started porting it to Ruby.

#### why?
I wanted to separate the difficulty of understanding and implementing the algorithm from the difficulty of producing a solution in a language I'm less comfortable with than Ruby (I'm very comfortable in JavaScript, but I don't have much experience with serverside Node). My plan was to port my solution back to one of the desired languages, probably either Python or js, after I got it working.

#### long story short,
I had a blast and learned a ton - this was my first time implementing a graph of any kind - but after implementing the algorithm, the De Bruijn graph it produced wasn't Eulerian (had no Eulerian path or cycle), which meant that I couldn't (easily/efficiently) assemble the chromosome.

I eventually realized (waaaay late) that this was due to the nature of the dataset. To produce an Eulerian De Bruijn graph, your reads must contain each kmer exactly once; each read in my dataset is guaranteed to consist of at least 50% duplicate kmers. This is why my De Bruijn graph had 100 semibalanced nodes (using basically any k value from 10 to 900) instead of 2 (head and tail).

Even though [my De Bruijn implementation](https://github.com/chellberg/genome) didn't produce a solution to this challenge, it's pretty neat. Check it out if you want.

A few hours ago, I read in a Wikipedia article I am now unable to locate that overlap-based approaches work best when there's a high degree of overlap between reads. E.g. the exact characteristic of my dataset.

Clearly, it was time to
# pivot

I started from scratch and implemented the greedy algorithm with no trouble, testing as I went, using [these fantastic, fascinating coursera videos](https://www.youtube.com/playlist?list=PL2mpR0RYFQsBiCWVJSvVAO3OJ2t7DzoHA) as a reference. The teacher is the author of the above Python De Bruijn implementation.

I already took an extra day, and it's pretty late now (2am), so I'm just submitting my Ruby solution. I'm confident I could implement it in one of the requested languages (and pick them up quickly on the job), but I'm not sufficiently familiar  with them to produce a well tested, idiomatic solution this late at night.

#### closing remarks

I understand that this means my solution fails to satisfy an important criteria of the challenge, but I'd rather be evaluated on good code in the wrong language than bad code in the right language.

Whether or not there's a fit, this challenge pushed me into unexplored algorithm/data structure territory. I learned a bunch and had fun. Thanks!

## Instructions
### setup
Make sure you have a Ruby >= 2.0 installed. If you don't already have Bundler installed, run `gem install bundler`. Then run `bundle install` to install the sole dependency, [minitest](https://github.com/seattlerb/minitest).

### how to run the tests
`ruby greedy_spec.rb` to run the spec

`ruby validate_real_data_solution.rb` to run a couple tests I wrote to validate that the chromosome string produced by my solution

  - contains every input read substring
  - is the same length across multiple runs with varying minimum overlap length

### how to run against the real data
`ruby run_with_real_data_and_print.rb`

or

`ruby run_with_real_data_and_write_to_file.rb` (writes to `output.txt`)

I also committed [the solution output] if you don't feel like running my code locally.
