# frozen_string_literal: true

require './lib/enumerable.rb'

describe Enumerable do
  let(:arr) { [1, 2, 7, 8, 5] }
  let(:n) {arr.length}

  describe '#my_each should' do
    it 'call the given block once for each element in self' do
      my_each_output = ''
      block = proc { |num| my_each_output += num.to_s }
      arr.each(&block)
      each_output = my_each_output.dup
      my_each_output = ''
      arr.my_each(&block)
      expect(my_each_output).to eq(each_output)
    end

    it 'return an enumerator if no block is given' do
      expect(arr.my_each.take n).to eql(arr.each.take n)
    end
  end

  describe '#my_each_with_index should' do
    it 'call the block for each element/index pair in the the array' do
      my_each_widx_output = ''
      block = proc { |i, idx| my_each_widx_output += i.to_s + idx.to_s }
      arr.each_with_index(&block)
      each_widx_output = my_each_widx_output.dup
      my_each_widx_output = ''
      arr.my_each_with_index(&block)
      expect(my_each_widx_output).to eql(each_widx_output)
    end

    it 'return an enumerator if no block is given' do
      result1 = arr.my_each_with_index
      result2 = arr.each_with_index
      expect(result1.take n).to eql(result2.take n)
    end
  end

  describe '#my_select should return' do
    it 'array of values that return true for a given block' do
      block = proc { |i| i.even? }
      expect(arr.my_select(&block)).to eql(arr.select(&block))
    end

    it 'array of values that return true for a given block' do
      result = %w[a b D].my_select { |i| i.match?(/^[A-Z]{1}$/) }
      expect(result).to eql(['D'])
    end

    it 'an enumerator if no block is given' do
      expect(arr.my_select.take n).to eql(arr.select.take n)
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
      expect(result).to eql(arr.map(&proc))
    end

    it 'an enumerator if no proc or block is given' do
      expect(arr.my_map.take n).to eql(arr.map.take n)
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
