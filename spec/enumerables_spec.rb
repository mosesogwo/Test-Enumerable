# frozen_string_literal: true

require './lib/enumerable.rb'

describe Enumerable do
  describe '#my_each should return' do
    it 'an array holding all elements of the given array' do
      arr = [1, 2, 7, 9]
      expect(arr.my_each).to eql([1, 2, 7, 9])
    end

    it 'an empty array if an empty array is given' do
      arr = []
      expect(arr.my_each).to eql([])
    end

    it 'an array of the yield for each element if given a block' do
      arr = [9, 4, 1]
      result = arr.my_each { |x| x + 2 }
      expect(result).to eql([11, 6, 3])
    end
  end

  describe '#my_each_with_index should return' do
    it 'the same array if no block is given' do
      arr = [0, 10, 8]
      result = arr.my_each_with_index
      expect(result).to eql([0, 10, 8])
    end

    it 'an empty array if an empty array is given' do
      result = [].my_each_with_index
      expect(result).to eql([])
    end

    it 'the yield for each (element, index) pair in the given array if block is given' do
      holder = []
      [0, 8, 7, 5].my_each_with_index do |i, idx|
        holder << i + idx
      end
      expect(holder).to eql([0, 9, 9, 8])
    end
  end

  describe '#my_select should return' do
    it 'array of values that return true for the block' do
      result = [4, 7, 6].my_select { |i| i.even? }
      expect(result).to eql([4, 6])
    end

    it 'array of values that return true for the block' do
      result = %w[a b D].my_select { |i| i.match?(/^[A-Z]{1}$/) }
      expect(result).to eql(['D'])
    end

    it 'empty array if given an empty array' do
      result = [].my_select { |i| i.match?(/^[A-Z]{1}$/) }
      expect(result).to eql([])
    end

    it 'the same array if no block is given' do
      result = [8, 9, 4, 2].my_select
      expect(result).to eql([8, 9, 4, 2])
    end
  end

  describe '#my_all? should return' do
    it 'false if the block does not yield true for all values of the array' do
      result = [0, 6, 4, 1, 2].my_all? { |i| i < 3 }
      expect(result).to eql(false)
    end

    it 'true if the block yields true for all values of the array' do
      result = [0, 6, 4, 1, 2].my_all? { |i| i.is_a?(Integer) }
      expect(result).to eql(true)
    end

    it 'true for an empty array' do
      result = [].my_all? { |i| i.is_a?(Integer) }
      expect(result).to eql(true)
    end
  end

  describe '#my_any should return' do
    it 'true if the block yields true for any element of the array' do
      result = [5, 7, 3, 1, 2].my_any? { |i| i.even? }
      expect(result).to eql(true)
    end

    it 'false if the block yields false for all elements of the array' do
      result = [4, 9, 10].my_any? { |i| i > 20 }
      expect(result).to eql(false)
    end

    it 'false for an empty array' do
      result = [].my_any? { |i| i > 20 }
      expect(result).to eql(false)
    end
  end

  describe '#my_none? should return' do
    it 'false if no block is given' do
      result = [5, 7, 5].my_none?
      expect(result).to eql(false)
    end

    it 'true if block yields false for all elements of the array' do
      result = [3, 5, 6, 7].my_none? { |i| i > 10 }
      expect(result).to eql(true)
    end

    it 'false if block yields true for any element of the array' do
      result = [3, 5, 6, 7].my_none? { |i| i.even? }
      expect(result).to eql(false)
    end
  end

  describe '#my_count should return' do
    it 'the length of array if no block and no arg is given' do
      result = [7, 1, 3, 5].my_count
      expect(result).to eql(4)
    end

    it 'the # of times a value in the array is equal to the arg given' do
      result = [7, 1, 3, 5].my_count(3)
      expect(result).to eql(1)
    end

    it 'the # of times a block yields true for the elements of the array if block is given' do
      result = [7, 1, 3, 5].my_count { |i| i**2 < 10 }
      expect(result).to eql(2)
    end

    it 'ignore the block if both block and arg are given' do
      result = [7, 1, 3, 5].my_count(5) { |i| i**2 < 10 }
      expect(result).to eql(1)
    end
  end

  describe '#my_map should return' do
    it 'an array of the result of proc call for each element if proc is given' do
      proc = proc { |i| i - 7 }
      result = [10, 12, 1].my_map(&proc)
      expect(result).to eql([3, 5, -6])
    end

    it 'an array of the yield for each element if block is given' do
      result = [10, 12, 1].my_map { |i| i * 2 }
      expect(result).to eql([20, 24, 2])
    end

    it 'same array if no proc or block is given' do
      result = [10, 12, 1].my_map
      expect(result).to eql([10, 12, 1])
    end
  end

  describe '#my_inject should return' do
    it 'the sum of all elements of the array' do
      result = [2, 4, 6].my_inject { |memo, i| memo + i }
      expect(result).to eql(12)
    end

    it 'the product of all elements of the array' do
      result = [2, 4, 6].my_inject { |memo, i| memo * i }
      expect(result).to eql(48)
    end

    it 'the product of all elements of the array including the arg' do
      result = [2, 4, 6].my_inject(2) { |memo, i| memo * i }
      expect(result).to eql(96)
    end

    it 'nil, if the array is empty and no arg is given' do
      result = [].my_inject { |memo, i| memo * i }
      expect(result).to be nil
    end
  end
end
