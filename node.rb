class Node
  attr_accessor :content, :next_node

  def initialize(content: nil, next_node: nil)
    @content = content
    @next_node = next_node
  end

  def length
    n = 1
    detect_next_node = next_node
    while detect_next_node
      n += 1
      detect_next_node = detect_next_node.next_node
    end
    n
  end

  def append(new_node)
    tail.next_node = new_node
  end

  def tail
    return self unless next_node
    next_node.tail
  end

  def content_for_nth_node(n)
    fail "There aren't #{n} nodes in the list" if n > length
    nth_node = self
    n.times do |i|
      nth_node = self.next_node
    end
    nth_node.content
  end

  def reverse(prev_node: nil)
    orig_next_node = next_node
    self.next_node = prev_node
    return self unless orig_next_node
    orig_next_node.reverse(prev_node: self)
  end

  def print_list
    next_content = next_node ? next_node.content : "nil"
    p "Current: #{content}, Next: #{next_content}"
    return nil unless next_node
    next_node.print_list
  end

end
