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
  # Will not move a block if there are other blocks on top of it
  # Returns true if block moved or false if it cound not move the block
  def move(block, new_position)
    current_position = find(block)
    if (current_position &&
        on_top(block).empty? &&
        new_position >= 0 &&
        new_position <= size()) then
      @stack[current_position].delete(block)
      @stack[new_position].push(block)
      true
    else
      false
    end
  end

  # Returns an array of any blocks that are on top of a specified block
  # returns nil if block is not found
  # returns an empty array if there are no blocks on top of the given block
  def on_top(block)
    position = find(block)
    if position then
      stack = @stack[position]
      stack[(stack.index(block) + 1)..]
    else
      nil
    end
  end

  # Returns true if we can move a block back to its original stack
  # returns false if there are other blocks on top of it
  # returns false if block is not found
  def return_block(block)
    position = find(block)
    if (position && on_top(block).empty?) then
      @stack[position] = @stack[position].pop
      true
    else
      false
    end
  end
end
