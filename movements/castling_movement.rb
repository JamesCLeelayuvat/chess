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
      #castle left white
      board_class.board[0][0] = nil
      board_class.board[4][0] = nil
      board_class.board[2][0] = king
      board_class.board[3][0] = rook_left
      king.column = 2
      king.row = 0
      rook_left.column = 3
      rook_left.row = 0
    else
      #castle left black
      board_class.board[0][7] = nil
      board_class.board[2][7] = king
      board_class.board[3][7] = rook_left
      king.column = 2
      king.row = 7
      rook_left.column = 3
      rook_left.row = 7
    end
  end

  def castle_right(color, board_class)
    king = get_king(color, board_class)
    rook_right = get_rooks(color, board_class)[1]
    if color == "white"
      #castle right white
      board_class.board[4][0] = nil
      board_class.board[7][0] = nil
      board_class.board[6][0] = king
      board_class.board[5][0] = rook_right
      king.column = 6
      king.row = 0
      rook_left.column = 5
      rook_left.row = 0
    else
      #castle right black
      board_class.board[4][7] = nil
      board_class.board[7][7] = nil
      board_class.board[6][7] = king
      board_class.board[5][7] = rook_right
      king.column = 6
      king.row = 7
      rook_left.column = 5
      rook_left.row = 7
    end
  end
end
