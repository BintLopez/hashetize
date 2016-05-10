require_relative '../diy_hash'
require_relative '../hash_entry'

describe DiyHash do
  let(:default_size)   { DiyHash::HASH_MAP_SIZE }
  let(:key)            { "key" }
  let(:value)          { "value" }
  let(:kv_pair)        { HashEntry.new(key: key, value: value) }
  let(:expected_index) { subject.index_for(kv_pair.key) }

  it "instantiates with default hash map size" do
    expect(subject.hash_map.length).to eq default_size
  end

  it "instantiates with array full of nodes" do
    expect(subject.hash_map.uniq.first).to be_a(Node)
  end

  describe '#index_for key' do
    it "hashes the an input value to the same index each time" do
      outputs = []
      3.times { |n| outputs << subject.index_for(key) }
      hashed = outputs.uniq
      expect(hashed.length).to eq 1
    end
  end

  describe '#store_at_index' do
    it "stores a hash entry object at a specific index in the underlying array" do
      subject.store_at_index(kv_pair, 0)
      expect(subject.hash_map.first.content).to eq kv_pair
    end
  end

  describe '#hashetize' do
    it "stores the key value pair at the calculated index" do
      subject.hashetize(kv_pair)
      expect(subject.hash_map[expected_index].content).to eq kv_pair
    end
  end

  describe '#lookup_value_for key' do
    before do
      subject.hashetize(kv_pair)
    end

    it "returns the value, given a key" do
      expect(subject.lookup_value_for(key)).to eq value
    end
  end

  context 'hashing collision' do
    let(:key_2) { "key_2" }
    let(:val_2) { "value_2" }
    let(:kv_pair_2) { HashEntry.new(key: key_2, value: val_2) }

    before do
      subject.hashetize(kv_pair)
      allow(key_2).to receive(:hash).and_return(key.hash)
    end

    context "adding a hash entry to the hash" do
      it "appends the kv_pair_2 to the linked list at the same index" do
        expect(key.hash).to eq key_2.hash
        expect(subject.index_for(key_2)).to eq expected_index
        expect(subject.hash_map[expected_index].content).to eq kv_pair

        subject.hashetize(kv_pair_2)
        expect(subject.hash_map[expected_index].next_node.content).to eq kv_pair_2
      end
    end

    context "getting the value for a key that's a collision" do
      before do
        subject.hashetize(kv_pair_2)
      end

      it "retrieves the value for key 2" do
        expect(subject.lookup_value_for(key_2)).to eq val_2
      end
    end
  end

end
