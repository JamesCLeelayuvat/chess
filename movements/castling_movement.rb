require_relative "../board.rb"

class CastlingMovements
  def get_king(color, board_class)
    if color == "white"
      board_class.white_pieces.select { |piece| piece.instance_of? King }[0]
    else
      board_class.black_pieces.select { |piece| piece.instance_of? King }[0]
    end
  end

  def get_rooks(color, board_class)
    if color == "white"
      board_class.white_pieces.select { |piece| piece.instance_of? Rook }
    else
      board_class.black_pieces.select { |piece| piece.instance_of? Rook }
    end
  end

  def can_castle_left?(color, board_class)
    #find the king and rooks
    king = get_king(color, board_class)
    rooks = get_rooks(color, board_class)
    if color == "white"
      ##check for free space and if the pieces have moved yet
      if board_class.board[1][0].nil? && board_class.board[2][0].nil? && board_class.board[3][0].nil? && king.has_moved == false && rooks[0].has_moved == false
        return true
      else
        return false
      end
    else
      if board_class.board[1][7].nil? && board_class.board[2][7].nil? && board_class.board[3][7].nil? && king.has_moved == false && rooks[7].has_moved == false
        return true
      else
        return false
      end
    end
  end

  def can_castle_right?(color, board_class)
    #find the king and rooks
    king = get_king(color, board_class)
    rooks = get_rooks(color, board_class)
    if color == "white"
      ##check for free space and if the pieces have moved yet
      if board_class.board[5][0].nil? && board_class.board[6][0].nil? && king.has_moved == false && rooks[1].has_moved == false
        return true
      else
        return false
      end
    else
      if board_class.board[5][7].nil? && board_class.board[6][7].nil? && king.has_moved == false && rooks[1].has_moved == false
        return true
      else
        return false
      end
    end
  end

  def castle_left(color, board_class)
    #get pieces
    king = get_king(color, board_class)
    rook_left = get_rooks(color, board_class)[0]
    if color == "white"
      board_class.board[0][0] = nil
      board_class.board[2][0] = king
      board_class.board[3][0] = rook_left
    else
      board_class.board[0][7] = nil
      board_class.board[2][7] = king
      board_class.board[3][7] = rook_left
    end
  end

  def castle_right(color, board_class)
    king = get_king(color, board_class)
    rook_right = get_rooks(color, board_class)[1]
    if color == "white"
      board_class.board[4][0] = nil
      board_class.board[7][0] = nil
      board_class.board[6][0] = king
      board_class.board[5][0] = rook_right
    else
      board_class.board[4][7] = nil
      board_class.board[7][7] = nil
      board_class.board[6][7] = king
      board_class.board[5][7] = rook_right
    end
  end
end

board = Board.new
board.new_board
board.display_board(board.board)
cm = CastlingMovements.new
p cm.can_castle_left?("white", board)
p cm.can_castle_right?("white", board)
