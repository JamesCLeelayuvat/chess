class Pawn
  attr_accessor :color, :has_moved, :column, :row
  def initialize(color, column, row)
    @color = color
    @has_moved = false
    @column = column
    @row = row
  end
end
