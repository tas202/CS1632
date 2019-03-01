# Town Object
class Town
  attr_reader :real_rubies
  attr_reader :fake_rubies

  def initialize(name, neighbor, realr, faker)
    @name = name
    @neighbors = neighbor
    @real_rubies = realr
    @fake_rubies = faker
  end

  def return_name
    @name
  end

  def return_num_neighbors
    @neighbors.length
  end

  def return_neighbor_name(num)
    @neighbors[num - 1]
  end

  def mine
    nrr = rand(0..@real_rubies)
    nfr = rand(0..@fake_rubies)
    [nrr, nfr]
  end
end
