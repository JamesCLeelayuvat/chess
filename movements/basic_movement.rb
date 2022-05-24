class Basic_Movement
  include Notation_Conversion

  def initialize
    @cm = Checking_Movements.new
  end

  #making a move
  def basic_move(move, color, focus, board)
    move_array = get_indices_from_notation(move)

    #determine the piece to be focused on
    if color == "white"
      focus_piece = focus.white_focus
    else
      focus_piece = focus.black_focus
    end
    #creating a valid moves array
    valid_moves_array = @cm.valid_moves_array(focus_piece, board.board, board)
    unless valid_moves_array.include?(move_array)
      return nil
    end
    #move is valid
    unless board[move[0]][move[1]].nil?
      board[move[0]][move[1]].captured == true
      board[move[0]][move[1]] = nil
    end
    #move the piece
    board[move[0]][move[1]] = focus_piece
    focus_piece.column = move[0]
    focus_piece.row = move[1]
  end

  def check_pin(move, color, focus, board)
  end
end
