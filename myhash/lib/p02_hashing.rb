class Fixnum
  # Fixnum#hash already implemented for you
  
end

class Array
  def hash
    resolved = nested_count
    self.each_with_index do |el, i|
      val = el.hash
      resolved += val * i
    end
    resolved
  end
  
  def nested_count
    count=1
    self.each do |x|
      
      count += x.nested_count if x.is_a?(Array)
      
    end 
    count
    
  end
end

class String
  
  def hash
    chars.map {|x| x.ord}.hash
    
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    
    binaries = 0
    self.keys.sort.each_with_index do |key, i|
      binaries = to_bin(binaries) + to_bin(key)
      binaries = to_bin(binaries) + to_bin(self[key] * i)
    end
    binaries
  end
  
  def to_bin(arg)
    arg.hash.to_s(2).to_i(2)
  end
end
