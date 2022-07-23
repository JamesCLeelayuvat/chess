class En_Passant
  attr_accessor :pawn_double_moved

  def initialize
    @pawn_double_moved = "none"
  end

  def move_en_passant_left(focus, color, board)
    if color == "white"
      pawn = focus.white_focus
    else
      pawn = focus.black_focus
    end
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

  def move_en_passant_right(focus, color, board)
    if color == "white"
      pawn = focus.white_focus
    else
      pawn = focus.black_focus
    end
    if pawn.color == "white"
      board[pawn.column + 1][pawn.row].captured = true
      board[pawn.column][pawn.row] = nil
      board[pawn.column + 1][pawn.row + 1] = pawn
      board[pawn.column + 1][pawn.row] = nil
      #change class info
      pawn.column = pawn.column + 1
      pawn.row = pawn.row + 1
    else
      board[pawn.column + 1][pawn.row - 1] = pawn
      board[pawn.column + 1][pawn.row].captured = true
      board[pawn.column + 1][pawn.row] = nil
      #change class info
      pawn.column = pawn.column + 1
      pawn.row = pawn.row - 1
    end
  end

  def en_passant_right?(pawn, board)
    #check right
    if pawn.color == "white" && pawn.column + 1 <= 7 && board[pawn.column + 1][pawn.row] == @pawn_double_moved
      return true
    end
  end

  def en_passant_left?(pawn, board)
    if pawn.column - 1 >= 0 && board[pawn.column - 1][pawn.row] == @pawn_double_moved
      return true
    end
  end

  def en_passant_to_letter_code(pawn, move, board)
    if pawn.color == "white"
      if board[pawn.column + 1][pawn.row + 1].nil?
        return "EPR"
      elsif board[pawn.column - 1][pawn.row + 1].nil?
        return "EPL"
      end
    else
      if board[pawn.column + 1][pawn.row - 1].nil?
        return "EPR"
      elsif board[pawn.column - 1][pawn.row - 1].nil?
        return "EPL"
      end
    end
  end

  def double_move(focus, color, move)
    if color == "white"
      piece = focus.white_focus
    else
      piece = focus.black_focus
    end
  end
end
