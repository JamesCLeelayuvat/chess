require_relative "./board.rb"
require_relative "./pieces/bishop.rb"
require_relative "./pieces/king.rb"
require_relative "./pieces/knight.rb"
require_relative "./pieces/pawn.rb"
require_relative "./pieces/queen.rb"
require_relative "./pieces/rook.rb"
require_relative "Notation_Conversion.rb"

class Prompts
include Notation_Conversion
  #initiates a prompt to the player and returns the piece that player selected
  #reinitiates prompt if input invalid
  def get_selection(color, board)
    loop do
      puts "Select a piece with algebraic notation"
      selection = get_indices_from_notation(gets.chomp)
      if selection.nil?
        next
      end
      if !board[selection[0]][selection[1]].nil? && board[selection[0]][selection[1]].color == color
        return board[selection[0]][selection[1]]
      end
      puts "Invalid selection! Please try again."
    end
  end

  

  def get_move_to(piece_class, board)
    loop do
      puts "Move to:"
      selection = get_indices_from_notation(gets.chomp)

    end
  end
end

board = Board.new
board.new_board
prompt = Prompts.new
p prompt.get_selection("white", board.board)
