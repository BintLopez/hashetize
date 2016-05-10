require_relative '../node'

describe Node do

  def create_rand_node
    values = ["panda", 12, "penguin", 85, "llama", 21, 19, "pigeon"]
    Node.new(content: values.sample)
  end

  let(:initial_node) { Node.new(content: "initial_value") }
  let!(:node_added_to_end) { create_rand_node }
  
  it "is an instance of Node class" do
    expect(initial_node).to be_a Node
  end

  it "has content" do
    expect(initial_node.content).to eq "initial_value"
  end

  it "can add a next node" do
    initial_node.append(node_added_to_end)
    expect(initial_node.next_node).to eq node_added_to_end
  end

  context "Node does not have a next node" do
    it "next node is nil" do
      expect(initial_node.next_node).to be nil
    end
  end

  context "Node has a next node" do   
    let(:next_node) { create_rand_node }

    before { initial_node.next_node = next_node } 
    it "points to the next node" do
      expect(initial_node.next_node).to eq next_node
    end
  end

  context "With list of length 3" do
    let!(:head_node) { create_rand_node }
    let!(:middle_node) { create_rand_node }
    let!(:tail_node) { create_rand_node }
    let!(:added_tail) { create_rand_node }

    before do
      head_node.next_node = middle_node
      middle_node.next_node = tail_node
    end

    it "head node knows how many nodes are linked" do
      expect(head_node.length).to eq(3)
    end

    it "can detect the tail" do
      expect(head_node.tail).to eq tail_node
    end

    it "can add to the end of the list" do
      head_node.append(added_tail)
      expect(head_node.tail).to eq added_tail
    end

    it "returns the value of the nth node" do
      n = 2
      expected_content = middle_node.content
      expect(head_node.content_for_nth_node(n)).to eq expected_content
    end
  end

  describe "#reverse" do

    def create_node_with_next(next_node)
      node = create_rand_node
      node.next_node = next_node
      node
    end

    let!(:orig_tail) { create_rand_node }
    let!(:orig_before_tail) { create_node_with_next(orig_tail) }
    let!(:orig_after_head) { create_node_with_next(orig_before_tail) }
    let!(:orig_head) { create_node_with_next(orig_after_head) }

    let(:expected_reversed_list) do
      orig_head.next_node = nil
      orig_after_head.next_node = orig_head
      orig_before_tail.next_node = orig_after_head
      orig_tail.next_node = orig_before_tail
      orig_tail
    end

    let(:reversed_list) { orig_head.reverse }

    it "reverses the list" do
      expect(reversed_list).to eq(expected_reversed_list)
    end
  end

end
