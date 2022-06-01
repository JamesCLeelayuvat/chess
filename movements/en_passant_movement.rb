class En_Passant
  attr_accessor :pawn_double_moved

  def initialize
    @pawn_double_moved = nil
  end

  def move_en_passant_left(pawn, board)
    board[pawn.column][pawn.row] = nil
    if pawn.color == "white"
      board[pawn.column - 1][pawn.row + 1] = pawn
      board[pawn.column][pawn.row] = nil
      #change class info
      pawn.column = pawn.column - 1
      pawn.row = pawn.row + 1
    else
      board[pawn.column - 1][pawn.row - 1] = pawn
      board[pawn.column][pawn.row] = nil
      #change class info
      pawn.column = pawn.column - 1
      pawn.row = pawn.row - 1
    end
  end

  def move_en_passant_right(pawn, board)
    board[pawn.column][pawn.row] = nil
    if pawn.color == "white"
      board[pawn.column + 1][pawn.row + 1] = pawn
      board[pawn.column][pawn.row] = nil
      #change class info
      pawn.column = pawn.column + 1
      pawn.row = pawn.row + 1
    else
      board[pawn.column + 1][pawn.row - 1] = pawn
      board[pawn.column][pawn.row] = nil
      #change class info
      pawn.column = pawn.column + 1
      pawn.row = pawn.row - 1
    end
  end

  def en_passant?(pawn, board)
    #check right
    if pawn.column + 1 <= 7 && board[pawn.column + 1][pawn.row] == @pawn_double_moved
      return true
      #check left
    elsif pawn.column - 1 >= 0 && board[pawn.column - 1][pawn.row] == @pawn_double_moved
      return true
    else
      return false
    end
  end
end
