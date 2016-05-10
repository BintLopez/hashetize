class HashEntry
  attr_reader :key
  attr_accessor :value

  def initialize(key:, value: nil)
    @key = key
    @value = value
  end

end
