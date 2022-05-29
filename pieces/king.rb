class King
  attr_accessor :color, :column, :row, :captured, :has_moved

  def initialize(color, column, row)
    @captured = false
    @color = color
    @has_moved = false
    @column = column
    @row = row
  end
end
