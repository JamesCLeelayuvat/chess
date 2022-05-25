require_relative "../Notation_Conversion.rb"
require_relative "../board.rb"
require_relative "focus.rb"
require_relative "checking_movements.rb"

class Basic_Movement
  include Notation_Conversion

  def initialize
    @cm = Checking_Movements.new
  end

  #making a move
  def basic_move(move, color, focus, board, board_class)
    #determine the piece to be focused on
    if color == "white"
      focus_piece = focus.white_focus
    else
      focus_piece = focus.black_focus
    end
    #creating a valid moves array
    valid_moves_array = @cm.valid_moves_array(focus_piece, board, board_class)
    unless valid_moves_array.include?(move)
      return nil
    end
    #move is valid
    unless board[move[0]][move[1]].nil?
      board[move[0]][move[1]].captured == true
      board[move[0]][move[1]] = nil
    end
    #move the piece
    board[move[0]][move[1]] = focus_piece
    board[focus_piece.column][focus_piece.row] == nil
    focus_piece.column = move[0]
    focus_piece.row = move[1]
  end

  def check_pin(move, color, focus, board)
  end
end

board = Board.new
board.new_board
board.display_board(board.board)
focus = Focus.new
focus.get_focus("white", board.board)
prompts = Prompts.new
bm = Basic_Movement.new
bm.basic_move(prompts.get_move_to_selection(), "white", focus, board.board, board)
board.display_board(board.board)
