module Enumerable

  def my_each(&block)
    i = 0
    while i < self.size
        block.call(self[i])
        i+=1
    end
    return self
  end

  def my_each_with_index(&block)
    i = 0
    while i < self.size
        block.call(self[i], i)
        i+=1
    end
    return self
  end

  def my_select(&block)
    selected_items = []
    self.my_each do |i|
      selected_items << i if block.call(i)
    end
    return selected_items
  end

  def my_all?(&block)
    block ||= lambda {|obj| obj}
    self.my_each do |i|
      unless block.call(i)
        return false
      end
    end
    return true
  end

  def my_any?(&block)
    block ||= lambda {|obj| obj}
    self.my_each do |i|
      if block.call(i)
        return true
      end
    end
    return false
  end

  def my_none?(&block)
    block ||= lambda {|obj| obj}
    self.my_each do |i|
      if block.call(i)
        return false
      end
    end
    return true
  end

  def my_count(num=nil, &block)
    count = 0;
    if num != nil
      self.my_each do |i|
        if i == num
          count += 1
        end
      end
    elsif block_given?
      self.my_each do |i|
        if block.call(i)
          count += 1
        end
      end
    else
      return self.size
    end
    return count
  end

  def my_map(&block)
    result_array = []
    my_each do |i|
      result_array << block.call(i)
    end
    return result_array
  end

  def my_inject
    sum = self[0]
    my_each do |i|
        sum = yield(sum, i)
    end
    return sum
  end

  def multiply_els(array)
    array.my_inject{ |product, item| product * item }
  end

end
