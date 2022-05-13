p require_relative "../Notation_Conversion.rb"
p require_relative "../board.rb"
p require_relative "../prompts.rb"

class Checking_Movements
  include Notation_Conversion

  def valid_moves_array_pawn(piece_class, column, row, board)
    valid_moves = []
    if piece_class.has_moved == false && row + 2 <= 7 && board[column][row + 1].nil?
      valid_moves.append([column, row + 2])
    end
    if row + 1 <= 7 && board[column][row + 1].nil?
      valid_moves.append([column, row + 1])
    end
    if row + 1 <= 7 && column + 1 <= 7 && !board[column + 1][row + 1].nil? && board[column + 1][row + 1].color != piece_class.color
      valid_moves.append([column + 1, row + 1])
    end
    if row + 1 <= 7 && column - 1 >= 0 && !board[column - 1][row + 1].nil? && board[column - 1][row + 1].color != piece_class.color
      valid_moves.append([column - 1, row + 1])
    end
    valid_moves
  end
end

board = Board.new.new_board
prompts = Prompt
p valid_moves_array_pawn(get_selection("white", board), 3, 1, board)
