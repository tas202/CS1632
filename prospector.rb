require_relative './town.rb'
# Prospector Object
class Prospector
  def initialize(start_town)
    @town = start_town
    @num_real_rubies = 0
    @num_fake_rubies = 0
    @days = 0
  end

  def return_town
    @town
  end

  def assign_town(town)
    @town = town
  end

  def return_rr
    @num_real_rubies
  end

  def return_fr
    @num_fake_rubies
  end

  def return_days
    @days
  end

  def search
    searching = true
    while searching == true
      ret = @town.mine
      print_mine_results ret
      increment_counters ret
      searching = false if (ret[0]).zero? && (ret[1]).zero? # if nothing is found end search

    end
    -1
  end

  def print_mine_results(ret)
    test_i = -1
    if ret[0] > 0 && ret[1] > 0
      print "\tFound #{ret[0]} #{ret[0] > 1 ? 'rubies' : 'ruby'} and #{ret[1]} fake #{ret[1] > 1 ? 'rubies' : 'ruby'}"
      puts " in #{@town.return_name}."
      test_i = 1
    elsif ret[0] > 0 && (ret[1]).zero?
      puts "\tFound #{ret[0]} #{ret[0] > 1 ? 'rubies' : 'ruby'} in #{@town.return_name}."
      test_i = 2
    elsif (ret[0]).zero? && ret[1] > 0
      puts "\tFound #{ret[1]} fake #{ret[1] > 1 ? 'rubies' : 'ruby'} in #{@town.return_name}."
      test_i = 3
    else
      puts "\tFound no rubies or fake rubies in #{@town.return_name}."
      test_i = 4
    end
    test_i
  end

  def increment_counters(ret)
    @num_real_rubies += ret[0]
    @num_fake_rubies += ret[1]
    @days += 1
  end

  def choose_next_town(map)
    # get the number of neighbors
    num_neighbors = @town.return_num_neighbors
    # get a random number between 1 and num_neighbors
    next_town = rand(1..num_neighbors)
    # set vars and get the name of the random neighbor
    found = false
    count = 0
    nt = @town.return_neighbor_name next_town
    # get the index of the next town in map
    while found == false
      # finding the index in count of the random neighbor
      return count if map[count].return_name == nt

      count += 1
    end
    nil
  end
end
