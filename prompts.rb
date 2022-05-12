require_relative "./board.rb"
require_relative "./pieces/bishop.rb"
require_relative "./pieces/king.rb"
require_relative "./pieces/knight.rb"
require_relative "./pieces/pawn.rb"
require_relative "./pieces/queen.rb"
require_relative "./pieces/rook.rb"

class Prompts
  #initiates a prompt to the player and returns the piece that player selected
  #reinitiates prompt if input invalid
  def get_selection(color, board)
    loop do
      puts "Select a piece with algebraic notation"
      selection = gets.chomp
      index_array = [0, 1, 2, 3, 4, 5, 6, 7]
      alphabet_array = ["a", "b", "c", "d", "e", "f", "g", "h"]
      selection = selection.split("")
      if selection[0].nil? || selection[1].nil?
        next
      end
      selection[0] = index_array[alphabet_array.index(selection[0])]
      selection[1] = selection[1].to_i - 1
      if !board[selection[0]][selection[1]].nil? && board[selection[0]][selection[1]].color == color
        return board[selection[0]][selection[1]]
      end
      puts "Invalid selection! Please try again."
    end
  end
end

board = Board.new
board.new_board
prompt = Prompts.new
p prompt.get_selection("white", board.board)
