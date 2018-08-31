class MaxIntSet
  def initialize(max)
    @array = Array.new(max, false)
  end
  
  def insert(num)
    is_valid?(num)
    @array[num] = true
  end
  
  def remove(num)
    is_valid?(num)
    @array[num] = false
  end
  
  def include?(num)
    is_valid?(num)
    @array[num]
  end
  
  private
  
  def is_valid?(num)
    raise "Out of bounds" if num < 0
    raise "Out of bounds" if num > @array.length
    true
  end
  
  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end
  
  def insert(num)
    @store[num % @store.length] << num unless include?(num)
  end
  
  def remove(num)
    @store[num % @store.length].delete(num) if include?(num)
  end
  
  def include?(num)
    @store[num % @store.length].include?(num)
  end
  
  private
  
  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end
  
  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  
  def insert(num, &prc)
    resize! if @count >= @store.length
    if include?(num)
      false 
    else 
      @store[num % @store.length] << num
      @count += 1
      prc.call(1) if prc
      true 
    end 
    
  end
  
  def length
    @store.length
  end
  
  def remove(num, &prc)
    if include?(num)
      @store[num % @store.length].delete(num)
      @count -=1
      prc.call(-1) if prc
    end 
    nil
  end
  
  def include?(num)
    @store[num % @store.length].include?(num)
  end
  
  private
  
  def num_buckets
    @store.length
  end
  
  def resize!(*args)
    old_array = @store 
    @store = Array.new(old_array.length*2){Array.new}
    @count = 0
    old_array.each do |bucket|
      bucket.each{ |el| insert(el) }
    end 
    
    
  end
end
