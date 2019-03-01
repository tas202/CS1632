require_relative './rr_methods.rb'

arg_check_length ARGV.length
arg_check_seed ARGV[0]
arg_check_prospectors ARGV[1]
arg_check_turns ARGV[2]
create_seed ARGV[0].to_i

num_prospectors = ARGV[1].to_i
num_turns = ARGV[2].to_i

(1..num_prospectors).each do |i|
  puts "Rubyist ##{i} starting in Enumerable Canyon."
  turns_left = num_turns
  map = create_towns
  p1 = Prospector.new map[0]
  while turns_left > 0
    search_town p1
    move p1, map, turns_left
    turns_left -= 1
  end
  print_p_stats i, p1
end

exit(0)
