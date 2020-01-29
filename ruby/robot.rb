require "minitest/autorun"

class Stack
  attr_accessor :stack
  
  def initialize(size = 2)
    @stack = Array.new(size)
    @stack = @stack.map.with_index { |x, i| i }
  end
  
  def size
    @stack.count
  end
end

describe Stack do
  describe "A new stack" do
    it "should have two elements" do
      my_stack = Stack.new()
      _(my_stack.size()).must_equal 2
    end

    it "should have zero as the first element" do
      my_stack = Stack.new()
      _(my_stack.stack[0]).must_equal 0
    end

    it "should have one as the second element" do
      my_stack = Stack.new()
      _(my_stack.stack[1]).must_equal 1
    end
  end
end
