require "minitest/autorun"
require_relative "robot"

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

    it "when two blocks are stacked we can find out what is on top of a block" do
      my_stack = Stacks.new(2)
      my_stack.move(1, 0)
      _(my_stack.on_top(0)).must_equal [1]
    end

    it "when two blocks are stacked there is nothing on top of the top block" do
      my_stack = Stacks.new(2)
      my_stack.move(1, 0)
      _(my_stack.on_top(1)).must_be_empty
    end

    it "when two blocks are stacked on_top returns nil for a non-existent block" do
      my_stack = Stacks.new(2)
      _(my_stack.on_top(-1)).must_be_nil
    end

    it "should not be possible to move a block from underneath another block" do
      my_stack = Stacks.new(2)
      my_stack.move(1, 0)
      _(my_stack.move(0, 1)).must_equal false
    end

    it "should be possible to return a block to its original position" do
      my_stack = Stacks.new(2)
      my_stack.move(1, 0)
      _(my_stack.return_block(1)).must_equal true
    end

    it "should not be possible to return a block if there is another on top" do
      my_stack = Stacks.new(2)
      my_stack.move(1, 0)
      _(my_stack.return_block(0)).must_equal false
    end
  end

  describe "A robot arm" do
    describe "when given a new block world of 3 blocks" do
      it "should not be able to move 0 over 0" do
        world = Stacks.new(3)
        robot = Robot.new(world)
        _(robot.move_over(0, 0)).must_equal false
      end

      it "should be able to move block 2 over block 0" do
        world = Stacks.new(3)
        robot = Robot.new(world)
        _(robot.move_over(2, 0)).must_equal true
        _(world.find(2)).must_equal 0
        _(world.find(1)).must_equal 1
        _(world.find(0)).must_equal 0
      end
    end
  end
end
