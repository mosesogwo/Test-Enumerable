require './lib/enumerable.rb'

describe Enumerable do

  describe '#my_each should return' do
    it 'an array holding all elements of the given array' do
      arr = [1 , 2, 7, 9]
      expect(arr.my_each).to eql([1, 2, 7, 9])
    end

    it 'an empty array if an empty array is given' do
      arr = []
      expect(arr.my_each).to eql([])
    end

    it 'an array of the yield for each element if given a block' do
      arr = [9, 4, 1]
      result = arr.my_each {|x| x + 2}
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
      result = [4, 7, 6].my_select {|i| i.even?}
      expect(result).to eql([4, 6])
    end

    it 'array of values that return true for the block' do
      result = ["a", "b", "D"].my_select {|i| i.match?(/^[A-Z]{1}$/)}
      expect(result).to eql(["D"])
    end

    it 'empty array if given an empty array' do
      result = [].my_select {|i| i.match?(/^[A-Z]{1}$/)}
      expect(result).to eql([])
    end

    it 'the same array if no block is given' do
      result = [8, 9, 4, 2].my_select
      expect(result).to eql([8, 9, 4, 2])
    end
  end

  describe '#my_all? should return' do
      it 'false if the block does not yield true for all values of the array' do
        result = [0, 6, 4, 1, 2].my_all? {|i| i < 3}
        expect(result).to eql(false)
      end

      it 'true if the block yields true for all values of the array' do
        result = [0, 6, 4, 1, 2].my_all? {|i| i.is_a?(Integer)}
        expect(result).to eql(true)
      end

      it 'true for an empty array' do
        result = [].my_all? {|i| i.is_a?(Integer)}
        expect(result).to eql(true)
      end
  end

  describe '#my_any should return' do
    it 'true if the block yields true for any element of the array' do
      result = [5, 7, 3, 1, 2].my_any? {|i| i.even?}
      expect(result).to eql(true)
    end

    it 'false if the block yields false for all elements of the array' do
      result = [4, 9, 10].my_any? {|i| i > 20}
      expect(result).to eql(false)
    end

    it 'false for an empty array' do
      result = [].my_any? {|i| i > 20}
      expect(result).to eql(false)
    end
  end

end



  # describe '#my_any?' do
  #   it 'returns true if the block is true for at least one of the elements of the enum, otherwise, return false' do
  #     expect([5, 7, 3, 1, 2].my_any? {|i| i.even?}).to eql(true)
  #     
  #   end
  # end

  # describe '#my_any?' do
  #   it 'returns false if the enumerable is empty' do
  #     expect([].my_any? {|i| i.even?}).to eql(false)
  #   end
  # end

  # describe '#my_none?' do
  #   it 'returns false if no block is given' do
  #     expect([5, 7, 5].my_none?).to eql(false)
  #   end
  # end

  # describe '#my_none?' do
  #   it 'returns true if the block returns false for all elements of the enum or enum is empty' do
  #     expect([3, 5, 6, 7].my_none? {|i| i.even?}).to eql(false)
  #     expect([3, 5, 6, 7].my_none? {|i| i > 10}).to eql(true)
  #     expect([].my_none? {||i| i < 10}).to eql(true)
  #   end
  # end

  # describe '#my_count' do
  #   it 'returns the # of times the block is true for each element of the enum' do
  #     expect([7, 1, 3, 5].my_count {|i| i ** 2 < 10}).to eql(2)
  #   end
  # end

  # describe '#my_count' do
  #   it 'returns the length of enum if no block and no arg is given' do
  #     expect([7, 1, 3, 5].my_count).to eql(4)
  #   end
  # end

  # describe '#my_count' do
  #   it 'returns the # of times the block yields a value equal to a given arg' do
  #     expect([7, 1, 3, 5].my_count(3)).to eql(1)
  #   end
  # end

  # describe '#my_count' do
  #   it 'returns zero if enum is empty' do
  #     expect([].my_count(3)).to eql(0)
  #   end
  # end


  # describe '#my_map' do
  #   it 'returns an enum of the result of proc for each element if proc is given' do
  #     proc = Proc.new {|i| i - 7}
  #     expect([10, 12, 1].my_map(&proc)).to eql([3, 5, -6])
  #   end
  # end

  # describe '#my_map' do
  #   it 'returns an enum of the yield for each element if block is given' do
  #     expect([10, 12, 1].my_map {|i| i * 2}).to eql([20, 24, 2])
  #   end
  # end

  # describe '#my_map' do
  #   it 'returns the enum if no proc and no block is given' do
  #     expect([10, 12, 1].my_map).to eql([10, 12, 1])
  #   end
  # end

  # describe '#my_map' do
  #   it 'returns empty enumerable if given enumerable is empty' do
  #     proc = Proc.new {|i| i - 7}
  #     expect([].my_map).to eql([])
  #     expect([].my_map {|i| i * 2}).to eql([])
  #     expect([].my_map(&proc)).to eql([])
  #   end
  # end

  # describe '#my_inject' do
  #   it 'combines all elements of an enum with a binary operation, start with zero if no arg is given' do
  #     expect([10, 20, 30].my_inject {|memo, i| memo + i}).to eql(60)
  #   end
  # end

  # describe '#my_inject' do
  #   it 'combines all elements of an enum with a binary operation, start with an arg if provided' do
  #     expect([10, 20, 30].my_inject(20) {|memo, i| memo * i}).to eql(120000)
  #   end
  # end