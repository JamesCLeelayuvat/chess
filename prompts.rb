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
    #checkloop
    loop do
      puts "Select a piece with algebraic notation"
      selection = get_indices_from_notation(gets.chomp)
      if selection.nil?
        next
      end
      if !board[selection[0]][selection[1]].nil? && board[selection[0]][selection[1]].color == color
        return board[selection[0]][selection[1]]
      end
      puts "Invalid selection. Please try again."
    end
  end

  #unfinished
  def get_move_to_selection(valid_moves_array, piece, board)
    input_invalid = true
    while input_invalid
      puts "Move to:"
      selection = get_indices_from_notation(gets.chomp)
      if piece.color == "white"
        if piece.column + 1 <= 7 && board[piece.column + 1][piece.row + 1] == nil && selection == [piece.column + 1, piece.row + 1]
          selection = "EPR"
        elsif piece.column - 1 >= 0 && board[piece.column - 1][piece.row + 1] == nil && selection == [piece.column - 1, piece.row + 1]
          selection = "EPL"
        end
      else
        if piece.column + 1 <= 7 && board[piece.column + 1][piece.row - 1] == nil && selection == [piece.column + 1, piece.row - 1]
          selection = "EPR"
        elsif piece.column - 1 >= 0 && board[piece.column - 1][piece.row - 1] == nil && selection == [piece.column - 1, piece.row - 1]
          selection = "EPL"
        end
      end
      #checkloop
      if valid_moves_array.include? selection
        input_invalid = false
        return selection
      end
    end
  end

  #select a piece
  def get_focus_selection(color, board)
    input_invalid = true
    while input_invalid
      puts "Select a piece:"
      selection = get_indices_from_notation(gets.chomp)
      #checkloop
      if !board[selection[0]][selection[1]].nil? && board[selection[0]][selection[1]].color == color
        input_invalid = false

        return board[selection[0]][selection[1]]
      end
      puts "Invalid selection. Please try another square."
    end
  end

  def get_promotion
    input_invalid = true
    #checkloop
    while input_invalid
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
      puts "Invalid promotion piece. Please try again."
    end
  end

  def player_to_move(turn_count)
    if turn_count % 2 == 0
      puts "White to move"
    else
      puts "Black to move"
    end
  end
end
