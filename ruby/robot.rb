require "minitest/autorun"

class Stacks
  attr_accessor :stack

  def initialize(size)
    @stack = Array.new(size)
    @stack = @stack.map.with_index { |x, i| [i] }
  end

  # The number of stacks
  def size
    @stack.count
  end

  # Returns the index of the stack that contains the block,
  # or nil if not found
  def find(block)
    found = @stack.map { |x| x.include?(block) }
    found.index(true)
  end

  # Moves a block from its current position onto the top of stack with index
  # new_position
  # Returns true if block moved or false if it cound not move the block
  def move(block, new_position)
    current_position = find(block)
    if (current_position &&
        new_position >= 0 &&
        new_position <= size()) then
      @stack[current_position].delete(block)
      @stack[new_position].push(block)
      true
    else
      false
    end
  end

  # def on_top
end

describe "Stacks" do
  describe "A new set of stacks" do
    it "should have two elements" do
      my_stack = Stacks.new(2)
      _(my_stack.size()).must_equal 2
    end

    it "should be possible to find a block" do
      my_stack = Stacks.new(2)
      _(my_stack.find(0)).must_equal 0
      _(my_stack.find(1)).must_equal 1
    end

    it "should not be possible to find a block that doesn't exist" do
      my_stack = Stacks.new(2)
      _(my_stack.find(2)).must_be_nil
    end

    it "should be possible to move a block from one index to another" do
      my_stack = Stacks.new(2)
      success = my_stack.move(1, 0)
      _(success).must_equal true
      _(my_stack.find(0)).must_equal 0
      _(my_stack.find(1)).must_equal 0
    end

    it "should not be possible to move a block to a non-existent stack" do
      my_stack = Stacks.new(2)
      success = my_stack.move(1,3)
      _(success).must_equal false
    end

    # it "when two blocks are stacked we can find out what is on top of a block" do
    #   my_stack = Stacks.new(2)
    #   my_stack.move(1, 0)
    #   _(my_stack.on_top(0)).must_equal [1]
    # end

    # it "should be possible to extract a block from underneath another block" do
    #   my_stack = Stacks.new(2)
    #   my_stack.move(1, 0)
    #   _(my_stack.find(0)).must_equal 0
    #   _(my_stack.find(1)).must_equal 0
    # end
  end
end
