require_relative "../Notation_Conversion.rb"
require_relative "../board.rb"
require_relative "../prompts.rb"

class Checking_Movements
  include Notation_Conversion

  def initialize
  end

  #returns an array of valid pawn moves, including captures
  def valid_moves_array_pawn(piece, board)
    column = piece.column
    row = piece.row
    valid_moves = []
    #double move
    if piece.has_moved == false && row + 2 <= 7 && board[column][row + 1].nil?
      valid_moves.append([column, row + 2])
    end
    if row + 1 <= 7 && board[column][row + 1].nil?
      valid_moves.append([column, row + 1])
    end
    #check for captures
    if row + 1 <= 7 && column + 1 <= 7 && !board[column + 1][row + 1].nil? && board[column + 1][row + 1].color != piece.color
      valid_moves.append([column + 1, row + 1])
    end
    if row + 1 <= 7 && column - 1 >= 0 && !board[column - 1][row + 1].nil? && board[column - 1][row + 1].color != piece.color
      valid_moves.append([column - 1, row + 1])
    end
    valid_moves
  end

  #returns an array of valid knight moves, including captures
  def valid_moves_array_knight(piece, board)
    column = piece.column
    row = piece.row
    valid_moves = []
    if column + 1 <= 7 && row + 2 <= 7 && (board[column + 1][row + 2].nil? || board[column + 1][row + 2].color != piece.color)
      valid_moves.append([column + 1, row + 2])
    end
    if column - 1 >= 0 && row + 2 <= 7 && (board[column - 1][row + 2].nil? || board[column - 1][row + 2].color != piece.color)
      valid_moves.append([column - 1, row + 2])
    end
    if column + 1 <= 7 && row - 2 >= 0 && (board[column + 1][row - 2].nil? || board[column + 1][row - 2].color != piece.color)
      valid_moves.append([column + 1, row - 2])
    end
    if column - 1 >= 0 && row - 2 >= 0 && (board[column - 1][row - 2].nil? || board[column - 1][row - 2].color != piece.color)
      valid_moves.append([column - 1, row - 2])
    end
    if column + 2 <= 7 && row + 1 <= 7 && (board[column + 2][row + 1].nil? || board[column + 2][row + 1].color != piece.color)
      valid_moves.append([column + 2, row + 1])
    end
    if column - 2 >= 0 && row + 1 <= 7 && (board[column - 2][row + 1].nil? || board[column - 2][row + 1].color != piece.color)
      valid_moves.append([column - 2, row + 1])
    end
    if column + 2 <= 7 && row - 1 >= 0 && (board[column + 2][row - 1].nil? || board[column + 2][row - 1].color != piece.color)
      valid_moves.append([column + 2, row - 1])
    end
    if column - 2 >= 0 && row - 1 >= 0 && (board[column - 2][row - 1].nil? || board[column - 2][row - 1].color != piece.color)
      valid_moves.append([column - 2, row - 1])
    end
    valid_moves
  end

  #returns array of valid moves for a rook
  def valid_moves_array_rook(piece, board)
    valid_moves = []
    column = piece.column
    row = piece.row
    #checking vertical up
    i = 1
    while row + i <= 7
      if !board[column][row + i].nil? && board[column][row + i].color == piece.color
        break
      elsif !board[column][row + i].nil? && board[column][row + i].color != piece.color
        valid_moves.append([column, row + i])
        break
      else
        valid_moves.append([column, row + i])
        i += 1
      end
    end
    #checking vertical down
    i = 1
    while row - i >= 0
      if !board[column][row - i].nil? && board[column][row - i].color == piece.color
        break
      elsif !board[column][row - i].nil? && board[column][row - i].color != piece.color
        valid_moves.append([column, row - i])
        break
      else
        valid_moves.append([column, row - i])
        i += 1
      end
    end
    #checking horizontal left
    i = 1
    while column - i >= 0
      if !board[column - i][row].nil? && board[column - i][row].color == piece.color
        break
      elsif !board[column - i][row].nil? && board[column - i][row].color != piece.color
        valid_moves.append([column - i, row])
        break
      else
        valid_moves.append([column - i, row])
        i += 1
      end
    end
    #checking horizontal right
    while column + i >= 0
      if !board[column + i][row].nil? && board[column + i][row].color == piece.color
        break
      elsif !board[column + i][row].nil? && board[column + i][row].color != piece.color
        valid_moves.append([column + i, row])
        break
      else
        valid_moves.append([column + i, row])
        i += 1
      end
    end
    valid_moves
  end

  def valid_moves_array_bishop(piece, board)
    valid_moves = []
    column = piece.column
    row = piece.row
    #checking ascending right
    i = 1
    while column + i <= 7 && row + i <= 7
      if !board[column + i][row + i].nil? && board[column + i][row + i].color == piece.color
        break
      elsif !board[column + i][row + i].nil? && board[column + i][row + i].color != piece.color
        valid_moves.append([column + i, row + i])
        break
      else
        valid_moves.append([column + i, row + i])
        i += 1
      end
    end
    #checking descending right
    i = 1
    while column + i <= 7 && row - i >= 0
      if !board[column + i][row - i].nil? && board[column + i][row - i].color == piece.color
        break
      elsif !board[column + i][row - i].nil? && board[column + i][row - i].color != piece.color
        valid_moves.append([column + i, row - i])
        break
      else
        valid_moves.append([column + i, row - i])
        i += 1
      end
    end
    #checking ascending left
    i = 1
    while column - i >= 0 && row + i <= 7
      if !board[column - i][row + i].nil? && board[column - i][row + i].color == piece.color
        break
      elsif !board[column - i][row + i].nil? && board[column - i][row + i].color != piece.color
        valid_moves.append([column - i, row + i])
        break
      else
        valid_moves.append([column - i, row + i])
        i += 1
      end
    end
    #checking descending left
    while column - i >= 0 && row - i >= 0
      if !board[column - i][row - i].nil? && board[column - i][row - i].color == piece.color
        break
      elsif !board[column - i][row - i].nil? && board[column - i][row - i].color != piece.color
        valid_moves.append([column - i, row - i])
        break
      else
        valid_moves.append([column - i, row - i])
        i += 1
      end
    end
    valid_moves
  end

  def valid_moves_array_queen(piece, board)
    return valid_moves_array_rook(piece, board) + valid_moves_array_bishop(piece, board)
  end

  def valid_moves_array_king(piece, board)
  
  end

  def valid_moves_array(piece, board)
  end
end

board = Board.new
board.new_board
board.display_board(board.board)
prompts = Prompts.new
cm = Checking_Movements.new
p cm.valid_moves_array_queen(prompts.get_selection("white", board.board), board.board)
