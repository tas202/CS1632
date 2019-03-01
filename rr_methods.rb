require_relative './town.rb'
require_relative './prospector.rb'
# check command line input
# format: ruby ruby_rush.rb <seed> <num_prospectors> <num_turns>
def arg_check_length(arg_l)
  if arg_l < 3
    puts 'Usage:\n'
    puts 'ruby ruby_rush.rb <seed> <num_prospectors> <num_turns>\n'
    puts '<seed> should be an integer\n'
    puts '<num_prospectors> should be a non-negative integer\n'
    puts '<num_turns> should be a non-negative integer\n\n'
    exit(1)
    return -1
  end
  0
end

def arg_check_seed(arg0)
  unless arg0 =~ /\A[-+]?[0-9]+\z/ # check if seed is an integer
    puts 'Usage:\n'
    puts 'ruby ruby_rush.rb <seed> <num_prospectors> <num_turns>\n'
    puts '<seed> should be an integer\n\n'
    exit(1)
    return -2
  end
  0
end

def arg_check_prospectors(arg1)
  unless /\A\d+\z/ =~ arg1 # check if num_turns is a pos int
    puts 'Usage:\n'
    puts 'ruby ruby_rush.rb <seed> <num_prospectors> <num_turns>\n'
    puts '<num_turns> should be a non-negative integer\n\n'
    exit(1)
    return -3
  end
  0
end

def arg_check_turns(arg2)
  unless /\A\d+\z/ =~ arg2 # check if num_prospectors is a pos int
    puts 'Usage:\n'
    puts 'ruby ruby_rush.rb <seed> <num_prospectors> <num_turns>\n'
    puts '<num_prospectors> should be a non-negative integer\n\n'
    exit(1)
    return -4
  end
  0
end

def create_seed(new_s)
  seed = new_s
  srand seed
  rand(0..100)
end

def create_towns
  t1 = Town.new 'Enumerable Canyon', ['Duck Type Beach', 'Monkey Patch City'], 1, 1
  t2 = Town.new 'Duck Type Beach', ['Enumerable Canyon', 'Matzburg'], 2, 2
  t3 = Town.new 'Monkey Patch City', ['Nil Town', 'Enumerable Canyon', 'Matzburg'], 1, 1
  t4 = Town.new 'Nil Town', ['Monkey Patch City', 'Hash Crossing'], 0, 3
  t5 = Town.new 'Matzburg', ['Monkey Patch City', 'Duck Type Beach', 'Hash Crossing', 'Dynamic Palisades'], 3, 0
  t6 = Town.new 'Hash Crossing', ['Matzburg', 'Nil Town', 'Dynamic Palisades'], 2, 2
  t7 = Town.new 'Dynamic Palisades', ['Matzburg', 'Hash Crossing'], 2, 2
  map = [t1, t2, t3, t4, t5, t6, t7]
end

def search_town(prospector)
  prospector.search
end

def move(prospector, map, turns_left)
  cur_town = prospector.return_town
  prev_town = cur_town.return_name # get town name for puts
  next_index = prospector.choose_next_town map # gets the index of the next town
  next_town = map[next_index] # sets the next town
  prospector.assign_town next_town # assigns the next town to the prospector
  # this prevents it from printing the last iteration
  puts "Heading from #{prev_town} to #{next_town.return_name}" if turns_left != 1
  -1
end

def print_p_stats(r_num, prospector)
  puts "After #{prospector.return_days} days, Rubyist ##{r_num} found:"
  puts "\t#{prospector.return_rr} #{prospector.return_rr.zero? || prospector.return_rr > 1 ? 'rubies' : 'ruby'}"
  puts "\t#{prospector.return_fr} fake #{prospector.return_fr.zero? || prospector.return_fr > 1 ? 'rubies' : 'ruby'}."
  # perfomance evaluation
  if prospector.return_rr >= 10
    puts 'Going home victorious!'
    return -1
  elsif prospector.return_rr >= 1
    puts 'Going home sad.'
    return -2
  else
    puts 'Going home empty-handed.'
    return -3
  end
end
