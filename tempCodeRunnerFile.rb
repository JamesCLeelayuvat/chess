class Test
  attr_accessor :var
  @var

  def initialize
    @var = 0
  end
end

test = Test.new
p test.var
test_clone = Marshal.load(Marshal.dump(test))
test_clone.var = 2
p test.var
p test_clone.var