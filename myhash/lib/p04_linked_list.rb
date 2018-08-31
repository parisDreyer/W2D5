class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
  
  def append(new_node)
    @next = new_node
    new_node.prev = self 
    
    
  end
end

class LinkedList
  
  include Enumerable
  
  def initialize
    @head = Node.new(:head, nil)
    @tail = Node.new(:tail, nil)
    @tail.prev= @head
    @head.next= @tail
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
    
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next== @tail
  end

  def get(key)
    find_by_key(key).val
  end

  def include?(key)
    find_by_key(key) != @head
  end

  def append(key, val)
    @tail.prev.append(Node.new(key,val).append(@tail))
  end

  def update(key, val)
    find_by_key(key).val = val
  end

  def remove(key)
    find_by_key(key).remove
  end

  def each
    next_node = @head.next 
    until next_node == @tail 
      yield(next_node)
      next_node = next_node.next
    end 
    self
  end

  private
  def find_by_key(key)
    prev= @tail
    until prev.key== key || prev == @head
      prev = prev.prev 
    end
    prev
  end
  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
