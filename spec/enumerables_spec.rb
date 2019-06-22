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

  
end
