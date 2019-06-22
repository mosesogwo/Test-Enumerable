# frozen_string_literal: true

require './lib/enumerable.rb'

describe Enumerable do
  let(:arr) { [1, 2, 7, 8, 5] }

  describe '#my_each should return' do
    it 'the yield at the instance of each element if given a block' do
      result = []
      arr.my_each { |x| result << x + 2 }
      expect(result).to eql([3, 4, 9, 10, 7])
    end

    # it 'an enumerator if no block is given' do
    #   expect(arr.my_each).to eql(arr.each)
    # end
  end

  describe '#my_each_with_index should return' do
    it 'the yield for each (element, index) pair in the given array if block is given' do
      holder = []
      arr.my_each_with_index { |i, idx| holder << i + idx }
      expect(holder).to eql([1, 3, 9, 11, 9])
    end

    it 'an enumerator if no block is given' do
      result = arr.my_each_with_index
      expect(result).to eql(arr.to_enum)
    end
  end

  describe '#my_select should return' do
    it 'array of values that return true for a given block' do
      result = arr.my_select { |i| i.even? }
      expect(result).to eql([2, 8])
    end

    it 'array of values that return true for a given block' do
      result = %w[a b D].my_select { |i| i.match?(/^[A-Z]{1}$/) }
      expect(result).to eql(['D'])
    end

    it 'an enumerator if no block is given' do
      expect(arr.my_select).to eql(arr.to_enum)
    end
  end

  describe '#my_all? should return' do
    it 'false if the block does not yield true for all elements of an array' do
      result = arr.my_all? { |i| i < 3 }
      expect(result).to eql(false)
    end

    it 'true if the block yields true for all values of the array' do
      result = arr.my_all? { |i| i.is_a?(Integer) }
      expect(result).to eql(true)
    end

    it 'true for an empty array' do
      result = [].my_all? { |i| i.is_a?(Integer) }
      expect(result).to eql(true)
    end
  end

  describe '#my_any should return' do
    it 'true if the block yields true for any element of the array' do
      result = arr.my_any? { |i| i.even? }
      expect(result).to eql(true)
    end

    it 'false if the block yields false for all elements of the array' do
      result = arr.my_any? { |i| i < 1 }
      expect(result).to eql(false)
    end

    it 'false for an empty array' do
      result = [].my_any? { |i| i > 20 }
      expect(result).to eql(false)
    end
  end

  describe '#my_none? should return' do
    it 'false if no block is given' do
      expect(arr.my_none?).to eql(false)
    end

    it 'true if block yields false for all elements of the array' do
      result = arr.my_none? { |i| i > 10 }
      expect(result).to eql(true)
    end

    it 'false if block yields true for any element of the array' do
      result = arr.my_none? { |i| i.even? }
      expect(result).to eql(false)
    end
  end

  describe '#my_count should return' do
    it 'the length of array if no block and no arg is given' do
      result = arr.my_count
      expect(result).to eql(5)
    end

    it 'the # of times a value in the array is equal to the arg given' do
      result = arr.my_count(3)
      expect(result).to eql(0)
    end

    it 'the # of times a block yields true for the elements of the array if block is given' do
      result = arr.my_count { |i| i**2 < 10 }
      expect(result).to eql(2)
    end

    it 'ignore the block if both block and arg are given' do
      result = arr.my_count(5) { |i| i**2 < 10 }
      expect(result).to eql(1)
    end
  end

  describe '#my_map should return' do
    it 'an array of the result of proc call for each element if proc is given' do
      proc = proc { |i| i - 7 }
      result = arr.my_map(&proc)
      expect(result).to eql([-6, -5, 0, 1, -2])
    end

    it 'an array of the yield for each element if block is given' do
      result = arr.my_map { |i| i * 2 }
      expect(result).to eql([2, 4, 14, 16, 10])
    end

    it 'an enumerator if no proc or block is given' do
      result = arr.my_map
      expect(result).to eql(arr.to_enum)
    end
  end

  describe '#my_inject should return' do
    it 'the sum of all elements of the array' do
      result = arr.my_inject { |memo, i| memo + i }
      expect(result).to eql(23)
    end

    it 'the product of all elements of the array' do
      result = arr.my_inject { |memo, i| memo * i }
      expect(result).to eql(560)
    end

    it 'the product of all elements of the array including the arg' do
      result = arr.my_inject(2) { |memo, i| memo * i }
      expect(result).to eql(1120)
    end

    it 'nil, if the array is empty and no arg is given' do
      result = [].my_inject { |memo, i| memo * i }
      expect(result).to be nil
    end
  end
end
