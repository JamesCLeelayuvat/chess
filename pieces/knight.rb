class Knight
  attr_accessor :color, :column, :row, :captured

  def initialize(color, column, row)
  @captured = false
    @color = color
    @column = column
    @row = row
  end
end
