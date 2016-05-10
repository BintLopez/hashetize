require_relative '../hash_entry'

describe HashEntry do

  it "instantiates with key and value" do
    hash_entry = HashEntry.new(key: "key", value: "value")
    expect(hash_entry.key).to eq "key"
    expect(hash_entry.value).to eq "value"
  end

  it "defaults to nil value" do
    hash_entry = HashEntry.new(key: "key")
    expect(hash_entry.value).to be nil
  end

end
