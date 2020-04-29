require_relative '../lib/enumerable_custom'

describe Enumerable do

  let(:array_list) { [1,2,3,4] }

  describe "#my_each" do
    it "should return the same array when a block is given" do
      expect(array_list.my_each { |item| item + 1  }).to eql(array_list)
    end

    it "should return an enumerator when no block is given" do
        expect(array_list.my_each).to be_an(Enumerator) 
    end
  end

  describe "#my_each_with_index" do
    it "should return the same array when a block is given" do
      expect(array_list.my_each_with_index { |item, index| item + 1  }).to eql(array_list)
    end

    it "should return an enumerator when no block is given" do
        expect(array_list.my_each_with_index).to be_an(Enumerator) 
    end
  end

  describe "#my_select" do 
    it "should return items that the result of the block is true" do
      expect(array_list.my_select { |item| item.even? }).to eql([2,4])
    end

    it "should return an empty list when the codition on block is false" do
        expect(array_list.my_select { |item| item.is_a?(String) }).to eql([])
    end

    it "should return an enumerator when no block is given" do
        expect(array_list.my_select).to be_an(Enumerator) 
    end
  end

  describe "#my_all" do
    it "should true when no block or argument is given, when none of the collection members are false or nil" do
        expect([1, 2, 3].my_all?).to eql(true)
    end

    it "should return false when atleast one of the items are nil or false" do
        expect([1, 2, nil].my_all?).to eql(false)
    end

    it "should return true when a class is passed as an argument  and when all of the collection is a member of such class" do
      expect([1, 2, 3].my_all?(Integer)).to eql(true)
    end

    it "should return false a class is passed as an argument  and when all of the collection is not a member of such class" do
      expect([1, 2, nil].my_all?(Integer)).to eql(false)
    end

    it "should return true when a Regex is passed as an argument and when all of the collection matches the Regex" do 
        expect(%w[dog door rod blade].my_all?(/d/)).to eql(true)
    end

    it "should return false when a Regex is passed as an argument and when all of the collection does not match the Regex" do 
        expect(%w[dog door rod blade].my_all?(/t/)).to eql(false)
    end

    it "should return true when a pattern other than Regex or a Class is given,  when all of the collection matches the pattern" do
        expect([3, 3, 3].my_all?(3)).to eql(true)
    end

    it "should return false when a pattern other than Regex or a Class is given,  when all of the collection does not match the pattern" do
        expect([3, 3, 3].my_all?(1)).to eql(false)
    end

    it "it should return true when the block is not given, adds an implicit block when at least one of the collection members is not false or nil.)" do
      expect([3, 3, 3].my_all?).to eql(true)
    end

    it "it should return true when the block is not given, adds an implicit block when at least one of the collection members is not false or nil.)" do
      expect([3, 3,  nil].my_all?).to eql(false)
    end
  end

  describe "#my_any" do
    it "should return true when no block or argument is given  and when at least one of the collection is not false" do
      expect([1, 2, 3].my_any?).to eql(true)
    end

    it "should return true when no block or argument is given or when nil" do
      expect([1, 2, nil].my_any?).to eql(true)
    end

    it "should return false when none of the items is different from nil" do
      expect([false, false, nil].my_any?).to eql(false)
    end

    it "should return true when a class is passed as an argument  and when at least one of the collection is a member of such class" do
      expect([1, 'demo', false].my_any?(Integer)).to eql(true)
    end

    it "should return false when a class is passed as an argument  and when at least one of the collection is not a member of such class" do
      expect(['demo', false, nil].my_any?(Integer)).to eql(false)
    end

    it "should return false when a Regex is passed as an argument and when none of the collection matches the Regex" do
      expect(%w[dog door rod blade].my_any?(/t/)).to eql(false)
    end

    it "should return true when a Regex is passed as an argument and when atleast one of the collection matches the Regex" do
      expect(%w[dog door rod blade].my_any?(/d/)).to eql(true)
    end

    it "should return false when a pattern other than Regex or a Class is given and when none of the collection matches the pattern" do
      expect([1, 2, 2].my_any?(3)).to eql(false)
    end

    it "should return true when a pattern other than Regex or a Class is given and when at leats one of the collection matches the pattern" do
      expect([1, 2, 3].my_any?(3)).to eql(true)
    end
  end

  describe "#my_none" do
    it "should return true when no block or argument is given  only when none of the collection members is true" do
      expect([false, nil, false].my_none?).to eql(true)
    end

    it "should return fasle when no block or argument is given  and only when one of the collection members is true" do
      expect([1, 'demo', 2.2].my_none?).to eql(false)
    end
  end
end