require './lib/enumerable.rb'

describe Enumerable do

  describe '#my_each' do
    it 'returns each element' do
      expect([0, 1, 2].my_each).to eql([0, 1, 2])
    end
  end

  describe '#my_each' do
    it 'returns the yield for each element if given a block' do
      expect([9, 4, 1].my_each {|x| x + 2}).to eql([11, 6, 3])
    end
  end

  # describe '#my_each_with_index' do
  #   it 'returns the same enumberable if no block is given' do
  #     expect([0, 10, 8].my_each_with_index).to eql([0, 10, 8])
  #   end
  # end

  describe '#my_select' do
    it 'returns an enumerator of values that return true for the block' do
      expect([4, 7, 6].my_select {|i| i.even?}).to eql([4, 6])
    end
  end

  describe '#my_select' do
    it 'returns an enumerator of values that return true for the block' do
      expect([0, 7, 9, 6, 3].my_select {|i| i < 5}).to eql([0, 3])
    end
  end

  describe '#my_all?' do
    it 'returns true if the block is true for all values of the enum' do
      expect([0, 6, 4, 1, 2].my_all? {|i| i < 3}).to eql(false)
    end
  end

  describe '#my_all?' do
    it 'returns true if the block is true for all values of the enum' do
      expect([0, 6, 4, 2].my_all? {|i| i.even?}).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if the block is true for at least one of the elements of the enum' do
      expect([5, 7, 3, 1, 2].my_any? {|i| i.even?}).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if the block is true for at least one of the elements of the enum' do
      expect([].my_any? {|i| i.even?}).to eql(false)
    end
  end

end