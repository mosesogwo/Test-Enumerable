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
end