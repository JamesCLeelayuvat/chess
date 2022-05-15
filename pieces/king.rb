class King
  attr_accessor :color, :column, :row

  def initialize(color, column, row)
    @color = color
    @has_moved = false
    @column = column
    @row = row
  end
end
