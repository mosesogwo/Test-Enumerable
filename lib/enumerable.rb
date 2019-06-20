# frozen_string_literal: true

# This module recreates each, each_with_index, select,
# all, any, none, count, map and inject enumerable methods.
module Enumerable
  def my_each
    each = []
    if block_given?
      for i in self
        each << (yield i)
      end
    else
      return self
    end
    each
  end

  def my_each_with_index
    idx = 0
    if block_given?
      for i in self
        yield(i, idx)
        idx += 1
      end
    else
      return self
    end
  end

  def my_select
    if block_given?
      collection = []
      self.my_each do |i|
        if yield i
          collection << i
        end
      end
    else
      return self
    end
    collection
  end

  def my_all?
    result = true
    self.my_each do |i|
      if not yield i 
        result = false
      end
    end
    result
  end

  def my_any?
    result = false
    self.my_each do |i|
      if yield i
        result = true
      end
    end
    result
  end

  def my_none?
    result = true
    if block_given?
      self.my_each do |i|
        if yield i
          result = false
        end
      end
    else
      return false
    end
    result
  end

  def my_count(arg=nil)
    count = 0
    if block_given?
      self.my_each do |i| 
        count += 1 if yield i
      end
    elsif not arg
      count = self.length
    else
      self.my_each do |i|
        count += 1 if i.equal?(arg)
      end
    end
    count
  end

  def my_map(&proc)
    result = []
    if proc
      self.my_each do |i|
        result << proc.call(i)
      end
    elsif block_given?
      self.my_each do |i|
        result << (yield i)
      end
    else
      result = self
    end
    result
  end

#   def my_inject (*memo)
#     if memo.size > 0
#       memo = memo[0].is_a?(Numeric) ? memo[0] : self.first
#     end
#     if block_given?
#       self.drop(1).each {|memo, i| memo = yield(memo, i)}
#     end
#     memo
#   end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, ele| product * ele }
end


p [].my_all?