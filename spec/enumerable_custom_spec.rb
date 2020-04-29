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
  end
end