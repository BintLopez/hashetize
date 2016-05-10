require_relative 'node'

class DiyHash
  attr_reader :hash_map

  HASH_MAP_SIZE = 1000

  def initialize(hash_entry: nil)
    @hash_map = Array.new(HASH_MAP_SIZE, Node.new)
  end

  def lookup_value_for(key, current_node: nil)
    current_node ||= hash_map[index_for(key)]
    return current_node.content.value if current_node.content.key == key
    lookup_value_for(key, current_node: current_node.next_node) unless current_node.next_node.nil?
  end

  def hashetize(key_value)
    store_at_index(key_value, index_for(key_value.key))
  end

  def index_for(key)
    key.hash % HASH_MAP_SIZE
  end

  def store_at_index(key_value, index)
    return hash_map[index].content = key_value unless collision_detected?(index)
    handle_collision(key_value, index)
  end

  def collision_detected?(index)
    !!hash_map[index].content
  end

  def handle_collision(key_value, index)
    hash_map[index].append(Node.new(content: key_value))
  end

end
