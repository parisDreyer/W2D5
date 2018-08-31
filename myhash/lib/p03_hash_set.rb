require_relative "p01_int_set"
require_relative "p02_hashing"


class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    
    @store = ResizingIntSet.new(8) #Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize!
    prc = Proc.new { |x| @count += x }
    @store.insert(key.hash, &prc)
  end

  def include?(key)
    @store.include?(key.hash)
  end

  def remove(key)
    prc = Proc.new { |x| @count += x }
    @store.remove(key.hash, &prc)
  end

  private

  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end

  def num_buckets
    @store.length
  end

  def resize!
    
    
  end
end
