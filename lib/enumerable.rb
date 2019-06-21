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
      return self.to_enum
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
    end
    result
  end

  def my_any?
    result = false
    my_each do |i|
      result = true if yield i
    end
    result
  end

  def my_none?
    result = true
    if block_given?
      my_each do |i|
        result = false if yield i
      end
    else
      return false
    end
    result
  end

  def my_count(arg = nil)
    count = 0
    if arg
      my_each do |i|
        count += 1 if i.equal?(arg)
      end
    elsif block_given?
      my_each do |i|
        count += 1 if yield i
      end
    else
      count = length
    end
    count
  end

  def my_map(&proc)
    result = []
    if proc
      my_each do |i|
        result << proc.call(i)
      end
    elsif block_given?
      my_each do |i|
        result << (yield i)
      end
    else
      result = self
    end
    result
  end

  def my_inject(*arg)
    if !arg.empty?
      memo = arg[0]
      my_each do |i|
        memo = (yield memo, i)
      end
    else
      memo = first
      drop(1).my_each do |i|
        memo = (yield memo, i)
      end
    end
    memo
  end
end
