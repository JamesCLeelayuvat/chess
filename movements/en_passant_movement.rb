class En_Passant
  attr_accessor :pawn_double_moved

  def initialize
    @pawn_double_moved = nil
  end

  def move_en_passant_left(pawn, board)
    board[pawn.column][pawn.row] = nil
    if pawn.color == "white"
      board[pawn.column - 1][pawn.row + 1] = pawn
      board[pawn.column - 1][pawn.row].captured = true
      board[pawn.column - 1][pawn.row] = nil
      #change class info
      pawn.column = pawn.column - 1
      pawn.row = pawn.row + 1
    else
      board[pawn.column - 1][pawn.row - 1] = pawn
      board[pawn.column - 1][pawn.row].captured = true
      board[pawn.column - 1][pawn.row] = nil
      #change class info
      pawn.column = pawn.column - 1
      pawn.row = pawn.row - 1
    end
  end

  def move_en_passant_right(pawn, board)
    board[pawn.column][pawn.row] = nil
    if pawn.color == "white"
      board[pawn.column + 1][pawn.row + 1] = pawn
      board[pawn.column + 1][pawn.row] = nil
      board[pawn.column + 1][pawn.row].captured = true
      #change class info
      pawn.column = pawn.column + 1
      pawn.row = pawn.row + 1
    else
      board[pawn.column + 1][pawn.row - 1] = pawn
      board[pawn.column + 1][pawn.row] = nil
      board[pawn.column + 1][pawn.row].captured = true
      #change class info
      pawn.column = pawn.column + 1
      pawn.row = pawn.row - 1
    end
  end

  def en_passant_right?(pawn, board)
    #check right
    if pawn.column + 1 <= 7 && board[pawn.column + 1][pawn.row] == @pawn_double_moved
      return true
    end
  end

  def en_passant_left?(pawn, board)
    if pawn.column - 1 >= 0 && board[pawn.column - 1][pawn.row] == @pawn_double_moved
      return true
    end
  end
end
