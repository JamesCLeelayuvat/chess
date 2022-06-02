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

  def initialize
  end

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
        break
      end
      puts "Invalid selection! Please try again."
    end
  end

  #unfinished
  def get_move_to_selection
    puts "Move to:"
    selection = get_indices_from_notation(gets.chomp)
    selection
  end

  #select a piece
  def get_focus_selection(board)
    puts "Select a piece:"
    selection = get_indices_from_notation(gets.chomp)
    board[selection[0]][selection[1]]
  end

  def get_promotion
    puts "Promote pawn to: (Q, B, K, R)"
    selection = gets.chomp
    case selection
    when "Q"
      return "Queen"
    when "B"
      return "Bishop"
    when "K"
      return "Knight"
    when "R"
      return "Rook"
    end
  end
end
