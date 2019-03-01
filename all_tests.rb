require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative 'rr_methods'
# Minitest for Ruby Rush
class RubyRushTest < Minitest::Test
  # UNIT TESTS FOR METHOD arg_check_length (arg_l)
  # Equivalence classes:
  # arg_l < 3 causes exit and returns -1
  # arg_l > 3 returns 0

  # This tests the method arg_check_length in rr_methods.
  # It sets the length argument to greater than 3 which is
  # enough for it to return 0.
  def test_arg_check_length_valid
    ret = arg_check_length 3
    assert_equal ret, 0
  end

  # This tests the method arg_check_length in rr_methods.
  # It sets the length argument to less than 3 which is
  # means it should print the usage and return with -1.
  # It uses a stub to ignore exit(x);
  # EDGE CASE
  def test_arg_check_length_fail
    def exit(x); 1; end;
    ret = arg_check_length 2
    assert_equal ret, -1
  end

  # UNIT TESTS FOR METHOD arg_check_seed (arg0)
  # Equivalence classes:
  # arg0 is not an integer causes exit and returns -2
  # arg0 is an integer returns 0

  # This tests the method arg_check_seed in rr_methods.
  # It sets the argument to 1 which is a valid seed. It should
  # return 0.
  def test_arg_check_seed_valid
    ret = arg_check_seed '1'
    assert_equal ret, 0
  end

  # This tests the method arg_check_seed in rr_methods.
  # It sets the argument to 1.6 which is an invalid seed since
  # it is a decimal. It should return -2.
  # EDGE CASE
  def test_arg_check_seed_decimal
    def exit(x); 1; end
    ret = arg_check_seed '1.6'
    assert_equal ret, -2
  end


  # UNIT TESTS FOR METHOD arg_check_prospectors (arg1)
  # Equivalence classes:
  # arg1 is not negative or an integer causes exit and returns -3
  # arg1 is positive and an integer returns 0

  # This tests the method arg_check_prospectors in rr_methods.
  # It sets the argument to 1 which is a valid input. It should
  # return 0.
  def test_arg_check_prospectors_valid
    ret = arg_check_prospectors '1'
    assert_equal ret, 0
  end

  # This tests the method arg_check_prospectors in rr_methods.
  # It sets the argument to 1.6 which is an invalid input since it
  # is a decimal. It should return -3.
  # EDGE CASE
  def test_arg_check_prospectors_decimal
    def exit(x); 1; end
    ret = arg_check_prospectors '1.6'
    assert_equal ret, -3
  end

  # This tests the method arg_check_prospectors in rr_methods.
  # It sets the argument to -1 which is an invalid input since it
  # is a negative. It should return -3.
  # EDGE CASE
  def test_arg_check_prospectors_negative
    def exit(x); 1; end
    ret = arg_check_prospectors '-1'
    assert_equal ret, -3
  end

  # UNIT TESTS FOR METHOD arg_check_turns (arg2)
  # Equivalence classes:
  # arg2 is not negative or an integer causes exit and returns -4
  # arg2 is positive and an integer returns 0

  # This tests the method arg_check_turns in rr_methods.
  # It sets the argument to 1 which is a valid input. It should
  # return 0.
  def test_arg_check_turns_valid
    ret = arg_check_turns '1'
    assert_equal ret, 0
  end

  # This tests the method arg_check_turns in rr_methods.
  # It sets the argument to 1.6 which is an invalid input since it
  # is a decimal. It should return -4.
  # EDGE CASE
  def test_arg_check_turns_decimal
    def exit(x); 1; end
    ret = arg_check_turns '1.6'
    assert_equal ret, -4
  end

  # This tests the method arg_check_turns in rr_methods.
  # It sets the argument to -1 which is an invalid input since it
  # is a negative. It should return -4.
  # EDGE CASE
  def test_arg_check_turns_negative
    def exit(x); 1; end
    ret = arg_check_turns '-1'
    assert_equal ret, -4
  end

  # This tests the method create_seed in rr_methods. The first
  # number generated after a new seed is set should be the
  # same each time. This tests creates two integers after each sets
  # the same seed so r1 should equal r2.
  def test_create_seed
    r1 = create_seed 123
    r2 = create_seed 123
    assert_equal r1, r2
  end

  # This tests the method create_towns in rr_methods. This method
  # creates seven instances of the Town object and initializes them
  # with the correct requirements of the ruby rush assignment.
  # To check they are create correctly it compares the name of a
  # town to what is should be.
  def test_create_towns
    t3 = Town::new 'Monkey Patch City', ['Nil Town', 'Enumerable Canyon', 'Matzburg'], 1, 1
    map = create_towns
    test_t = map[2]
    assert_equal t3.return_name, test_t.return_name
  end

  # This tests the method return_name in town.rb. It simply
  # returns the name of the instance of the town that called
  # it. It asserts that it should be the same as the correct name.
  def test_return_name
    t = Town::new 'Dynamic Palisades', ['Matzburg', 'Hash Crossing'], 2, 2
    name = t.return_name
    assert_equal name, 'Dynamic Palisades'
  end

  # This tests the method return_num_neighbors in town.rb.
  # It simply returns the number of neighbors of
  # the instance of the town that called it. It asserts that
  # it should be the same as the correct the correct number
  # of neighbors.
  def test_return_num_neighbors
    t = Town::new 'Dynamic Palisades', ['Matzburg', 'Hash Crossing'], 2, 2
    num_neighbors = t.return_num_neighbors
    assert_equal num_neighbors, 2
  end

  # This tests the method return_neighbor_name in town.rb.
  # It takes an index as an input and returns the name of
  # the neighbor at that index of the instance of the town
  # that called it. It asserts that it should be the same as
  # the correct name of the neighbor.
  def test_return_neighbor_name
    t = Town::new 'Dynamic Palisades', ['Matzburg', 'Hash Crossing'], 2, 2
    n_name = t.return_neighbor_name 1
    assert_equal n_name, 'Matzburg'
  end

  # This tests the method mine in town.rb. Mine creates two
  # random variables from 0 to the max which is the number of
  # real rubies and fake rubies respectibly. It then returns them
  # in a length two array. This asserts that two executions of Mine
  # with the same seed sequence will result in the same dig results.
  def test_mine
    t = Town::new 'Dynamic Palisades', ['Matzburg', 'Hash Crossing'], 2, 2
    create_seed 8
    dig_results1 = t.mine
    create_seed 8
    dig_results2 = t.mine
    assert_equal dig_results1, dig_results2
  end

  # This tests the method return_town in prospector.rb. It should
  # return the current town of the prospector that called it.
  def test_return_town
    map = create_towns
    p1 = Prospector::new map[0]
    s_town = p1.return_town
    t = Town::new 'Enumerable Canyon', ['Duck Type Beach', 'Monkey Patch City'], 1, 1
    assert_equal s_town.return_name, t.return_name
  end

  # This tests the method assign_town in prospector.rb. It should
  # set the current town of the prospector that called it to the
  # inputed town argument.
  def test_assign_town
    map = create_towns
    p1 = Prospector::new map[0]
    n_town = map[1] # pick the next town to set
    p1.assign_town n_town
    s_town = p1.return_town
    t = Town::new 'Duck Type Beach', ['Enumerable Canyon', 'Matzburg'], 2, 2
    assert_equal s_town.return_name, t.return_name
  end

  # This tests the method return_rr in prospector.rb. It should
  # return the number of real rubies that the prospector
  # that called it posseses.
  def test_return_rr
    map = create_towns
    p1 = Prospector::new map[0]
    nrr = p1.return_rr
    assert_equal nrr, 0
  end

  # This tests the method return_fr in prospector.rb. It should
  # return the number of fake rubies that the prospector
  # that called it posseses.
  def test_return_fr
    map = create_towns
    p1 = Prospector::new map[0]
    nfr = p1.return_fr
    assert_equal nfr, 0
  end

  # This tests the method return_days in prospector.rb. It should
  # return the number of days(times mined) that the prospector
  # that called it has lasted.
  def test_return_days
    map = create_towns
    p1 = Prospector::new map[0]
    days = p1.return_days
    assert_equal days, 0
  end

  # UNIT TESTS FOR METHOD print_mine_results (ret)
  # Equivalence classes:
  # ret = [>0, >0] => prints and returns 1
  # ret = [>0, =0] => prints and returns 2
  # ret = [=0, >0] => prints and returns 3
  # ret = [=0, =0] => prints and returns 4

  # This tests the method print_mine_results in prospertor.rb.
  # It takes an input from a mine ([int, int]) and prints
  # the associated mine results statement. For each path a
  # unique int is returned to check in the assert.
  def test_print_mine_results_1
    map = create_towns
    p1 = Prospector::new map[0]
    ret = [1, 1]
    test_i = p1.print_mine_results ret
    assert_equal test_i, 1
  end

  # This tests the method print_mine_results in prospertor.rb.
  # It takes an input from a mine ([int, int]) and prints
  # the associated mine results statement. For each path a
  # unique int is returned to check in the assert.
  def test_print_mine_results_2
    map = create_towns
    p1 = Prospector::new map[0]
    ret = [1, 0]
    test_i = p1.print_mine_results ret
    assert_equal test_i, 2
  end

  # This tests the method print_mine_results in prospertor.rb.
  # It takes an input from a mine ([int, int]) and prints
  # the associated mine results statement. For each path a
  # unique int is returned to check in the assert.
  def test_print_mine_results_3
    map = create_towns
    p1 = Prospector::new map[0]
    ret = [0, 1]
    test_i = p1.print_mine_results ret
    assert_equal test_i, 3
  end

  # This tests the method print_mine_results in prospertor.rb.
  # It takes an input from a mine ([int, int]) and prints
  # the associated mine results statement. For each path a
  # unique int is returned to check in the assert.
  def test_print_mine_results_4
    map = create_towns
    p1 = Prospector::new map[0]
    ret = [0, 0]
    test_i = p1.print_mine_results ret
    assert_equal test_i, 4
  end

  # This tests the method increment_counters in prospector.rb.
  # It takes a mine result ([x1, x2]) as an input and incrments
  # num_real_rubies by x1, num_fake_rubies by x2 and days by 1.
  # This has 3 assertions to make sure each correclty increments.
  def test_increment_counters
    map = create_towns
    p1 = Prospector::new map[0]
    ret = [1, 1]
    p1.increment_counters ret
    assert_equal p1.return_rr, 1
    assert_equal p1.return_fr, 1
    assert_equal p1.return_days, 1
  end

  # This tests the search method in prospector.rb. Search outlines
  # the process of searching a town. It iterates a while loop until
  # 0 real rubies and fake rubies are found. It calls print,
  # increment and mine methods. Since each of these methods are
  # previously tested this test just tests they run in correct
  # sycnhonization and complete the loop.
  def test_search
    mock_town = Minitest::Mock.new('Town')
    def mock_town.mine; [0, 0]; end

    def mock_town.return_name; 'Name'; end

    p1 = Prospector::new mock_town
    test_i = p1.search
    assert_equal test_i, -1
  end

  # This tests the choose_next_town method in prospector.rb.
  # The method takes an array of towns as an input and decides
  # the town a prospector will visit next. It gets a random
  # number between 0 and number of neighbors. Then it uses that
  # index with return_neighbor_name and the map to select the next
  # town and returns that towns index in the map array.
  def test_choose_next_town
    map = create_towns
    t = Town::new 'Enumerable Canyon', ['Duck Type Beach'], 1, 1
    p1 = Prospector::new t
    test_i = p1.choose_next_town map
    assert_equal test_i, 1
  end

  # This tests the search_town method in rr_methods.rb. This test
  # uses the mock and expect functions of Minitest to ensure
  # the two functions return_town and search are correctly called.
  def test_search_town
    mock_prospector = Minitest::Mock.new('mock_prospector')
    mock_prospector.expect :return_town, 1
    mock_prospector.expect :search, 1
    search_town mock_prospector
    assert_mock mock_prospector
  end

  # This tests the move method in rr_methods.rb. Move
  # takes 3 inputs, a prospector, an array of towns, and an int
  # turns_left. Since each of the individual functions in it are
  # already tested, this test simply verifies that the execute in
  # sequence.
  def test_move
    map = create_towns
    p1 = Prospector::new map[0]
    test_i = move p1, map, 2
    assert test_i, -1
  end

  # UNIT TESTS FOR METHOD print_p_stats (r_num, prospector)
  # Equivalence classes:
  # Passes in a prospector with attribute real_rubies = 10
  # which prints and returns -1.
  # Passes in a prospector with attribute real_rubies = 1
  # which prints and returns -2.
  # Passes in a prospector with attribute real_rubies = 0
  # which prints and returns -3.

  # This tests the print_p_stats method in rr_methods.rb. It
  # uses mocks and stubs in place of the actual objects and
  # methods. In this tests it makes rr 10 which results in a
  # victorious run and should return -1.
  def test_print_p_stats_victorious
    i = 1
    mock_prospector = Minitest::Mock.new("mock_prospector")
    def mock_prospector.return_days; 1; end
    def mock_prospector.return_rr; 10; end
    def mock_prospector.return_fr; 1; end
    test_i = print_p_stats i, mock_prospector
    assert test_i, -1
  end

  # This tests the print_p_stats method in rr_methods.rb. It
  # uses mocks and stubs in place of the actual objects and
  # methods. In this tests it makes rr 1 which results in a
  # sad run and should return -1.
  def test_print_p_stats_sad
    i = 1
    mock_prospector = Minitest::Mock.new("mock_prospector")
    def mock_prospector.return_days; 1; end
    def mock_prospector.return_rr; 1; end
    def mock_prospector.return_fr; 1; end
    test_i = print_p_stats i, mock_prospector
    assert test_i, -2
  end

  # This tests the print_p_stats method in rr_methods.rb. It
  # uses mocks and stubs in place of the actual objects and
  # methods. In this tests it makes rr 0 which results in a
  # empty run and should return -1.
  def test_print_p_stats_empty
    i = 1
    mock_prospector = Minitest::Mock.new("mock_prospector")
    def mock_prospector.return_days; 1; end
    def mock_prospector.return_rr; 0; end
    def mock_prospector.return_fr; 1; end
    test_i = print_p_stats i, mock_prospector
    assert test_i, -3
  end
end
