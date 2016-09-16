require_relative 'greedy'

greedy = Greedy.new('real_data.txt', minimum_overlap: 450)

puts greedy.shortest_common_superstring
