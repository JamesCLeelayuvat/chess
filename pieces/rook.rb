class Rook
  attr_accessor :color

  def initialize(color)
    @color = color
    @has_moved = false
  end
end
