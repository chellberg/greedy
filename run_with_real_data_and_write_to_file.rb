require_relative 'greedy'

greedy = Greedy.new('real_data.txt', minimum_overlap: 450)

f = File.open('output.txt', 'w')
f << greedy.shortest_common_superstring
f.close
