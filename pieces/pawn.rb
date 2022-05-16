class Pawn
  attr_accessor :color, :has_moved, :column, :row, :captured
  def initialize(color, column, row)
  @captured = false
    @color = color
    @has_moved = false
    @column = column
    @row = row
  end
end
