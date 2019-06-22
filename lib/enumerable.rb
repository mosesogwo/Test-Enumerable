# frozen_string_literal: true

# This module recreates each, each_with_index, select,
# all, any, none, count, map and inject enumerable methods.
module Enumerable
  def my_each
    if block_given?
      for i in self
        yield i
      end
      self
    else
      return self.to_enum
    end
  end

  def my_each_with_index
    idx = 0
    if block_given?
      my_each do |i|
        yield(i, idx)
        idx += 1
      end
    else
      return to_enum
    end
  end

  def my_select
    if block_given?
      collection = []
      my_each do |i|
        collection << i if yield i
      end
    else
      return self.to_enum
    end
    collection
  end

  def my_all?
    result = true
    my_each do |i|
      result = false unless yield i
      break if not result
    end
    result
  end

end

p [1, 2, 7, 8, 5].my_select
# p [1, 2, 7, 8, 5].my_each_with_index
# {|x| x + 1}