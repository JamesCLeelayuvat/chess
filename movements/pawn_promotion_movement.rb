require_relative "../prompts.rb"
require_relative "../board.rb"

class Pawn_Promotion_Movement
  def initialize
    @prompts = Prompts.new
  end

  def promotable?(pawn)
    if pawn.row == 7
      return true
    else
      return false
    end
  end

  def add_piece_to_list(piece, board)
    if piece.color == "white"
      board.white_pieces.append(piece)
    else
      board.black_pieces.append(piece)
    end
  end

  def remove_piece_from_list(piece, board)
    if piece.color == "white"
      board.white_pieces.delete(piece)
    else
      board.black_pieces.delete(piece)
    end
  end

  def promote_pawn(pawn, board)
    promote_to = @prompts.get_promotion
    case promote_to
    when "Queen"
      board.board[pawn.column][pawn.row] = Queen.new(pawn.color, pawn.column, pawn.row)
      add_piece_to_list(board.board[pawn.column][pawn.row], board)
      remove_piece_from_list(pawn, board)
    when "Rook"
      board.board[pawn.column][pawn.row] = Rook.new(pawn.color, pawn.column, pawn.row)
      add_piece_to_list(board.board[pawn.column][pawn.row], board)
      remove_piece_from_list(pawn, board)
    when "Bishop"
      board.board[pawn.column][pawn.row] = Bishop.new(pawn.color, pawn.column, pawn.row)
      add_piece_to_list(board.board[pawn.column][pawn.row], board)
      remove_piece_from_list(pawn, board)
    when "Knight"
      board.board[pawn.column][pawn.row] = Knight.new(pawn.color, pawn.column, pawn.row)
      add_piece_to_list(board.board[pawn.column][pawn.row], board)
      remove_piece_from_list(pawn, board)
    end
  end
end

board = Board.new
board.new_board
board.display_board(board.board)
ppm = Pawn_Promotion_Movement.new
ppm.promote_pawn(board.board[1][1], board)
board.display_board(board.board)
