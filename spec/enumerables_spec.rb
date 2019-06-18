require './lib/enumerable.rb'

describe Enumerable do

  describe '#my_each' do
    it 'returns each element' do
      expect([0, 1, 2].my_each).to eql([0, 1, 2])
      expect([].my_each).to eql([])
    end
  end

  describe '#my_each' do
    it 'returns the yield for each element if given a block' do
      expect([9, 4, 1].my_each {|x| x + 2}).to eql([11, 6, 3])
    end
  end

  describe '#my_each_with_index' do
    it 'returns the same enumberable if no block is given' do
      expect([0, 10, 8].my_each_with_index).to eql([0, 10, 8])
      expect([].my_each_with_index).to eql([])
    end
  end

  describe '#my_each_with_index' do
    it 'calls block for each [value, index] pair in the enumerable' do
      arr = []
      [0, 8, 7, 5].my_each_with_index {|i, idx| arr << i+idx}
      expect(arr).to eql([0, 9, 9, 8])
    end
  end

  describe '#my_select' do
    it 'returns an enumerator of values that return true for the block' do
      expect([4, 7, 6].my_select {|i| i.even?}).to eql([4, 6])
      expect(["a", "b", "D"].my_select {|i| i.match?(/^[A-Z]{1}$/)}).to eql(["D"])
      expect([0, 7, 9, 6, 3].my_select {|i| i < 5}).to eql([0, 3])
    end
  end

  describe '#my_all?' do
    it 'returns false if the block is not true for all values of the enum' do
      expect([0, 6, 4, 1, 2].my_all? {|i| i < 3}).to eql(false)
    end
  end

  describe '#my_all?' do
    it 'returns true if the block is true for all values of the enum and for an empty array' do
      expect([0, 6, 4, 2].my_all? {|i| i.even?}).to eql(true)
      expect([].my_all? {|i| i.even?}).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if the block is true for at least one of the elements of the enum' do
      expect([5, 7, 3, 1, 2].my_any? {|i| i.even?}).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns false if the block is empty' do
      expect([].my_any? {|i| i.even?}).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'returns true if no block is given' do
      expect([].my_none? {|i| i.even?}).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'returns true if the block returns false for all elements of the enum' do
      expect([3, 5, 6, 7].my_none? {|i| i.even?}).to eql(false)
    end
  end

  describe '#my_count' do
    it 'returns the # of times the block is true for each element of the enum' do
      expect([7, 1, 3, 5].my_count {|i| i ** 2 < 10}).to eql(2)
    end
  end

  describe '#my_count' do
    it 'returns the length of enum if no block and no arg is given' do
      expect([7, 1, 3, 5].my_count).to eql(4)
    end
  end

  describe '#my_count' do
    it 'returns the # of times the block yields a value equal to a given arg' do
      expect([7, 1, 3, 5].my_count(3)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'returns an enum of the result of proc for each element if proc is given' do
      proc = Proc.new {|i| i - 7}
      expect([10, 12, 1].my_map(&proc)).to eql([3, 5, -6])
    end
  end

  describe '#my_map' do
    it 'returns an enum of the yield for each element if block is given' do
      expect([10, 12, 1].my_map {|i| i * 2}).to eql([20, 24, 2])
    end
  end

  describe '#my_map' do
    it 'returns the enum if no proc and no block is given' do
      expect([10, 12, 1].my_map).to eql([10, 12, 1])
    end
  end

  describe '#my_inject' do
    it 'combines all elements of an enum with a binary operation, start with zero if no arg is given' do
      expect([10, 20, 30].my_inject {|memo, i| memo + i}).to eql(60)
    end
  end

  describe '#my_inject' do
    it 'combines all elements of an enum with a binary operation, start with an arg if provided' do
      expect([10, 20, 30].my_inject(20) {|memo, i| memo + i}).to eql(80)
    end
  end

end