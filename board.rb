require_relative "./pieces/bishop.rb"
require_relative "./pieces/king.rb"
require_relative "./pieces/knight.rb"
require_relative "./pieces/pawn.rb"
require_relative "./pieces/queen.rb"
require_relative "./pieces/rook.rb"

module Displayable
  private

  def print_top_coordinates
    puts "\e[0;33m a b c d e f g h\e[0m"
  end

  public

  def display_board(board)
    print_top_coordinates
    board_visual = ""
    8.times do |i|
      k = 7 - i
      board_visual += "\e[0;33m#{k + 1}\e[0m"
      8.times do |j|
        if (k + j) % 2 == 1
          board_visual += "\e[47#{get_color_from_class(board[j][k])}m#{get_symbol_from_class(board[j][k])} \e[0m"
        else
          board_visual += "\e[42#{get_color_from_class(board[j][k])}m#{get_symbol_from_class(board[j][k])} \e[0m"
        end
      end
      board_visual += "\n"
    end
    puts board_visual
  end

  def get_color_from_class(piece_class)
    if piece_class.nil?
      return nil
    end
    if piece_class.color == "white"
      return ";37"
    else
      return ";30"
    end
  end

  def get_symbol_from_class(piece_class)
    case
    when piece_class.instance_of?(Pawn) && piece_class.color == "white"
      return "♟"
    when piece_class.instance_of?(Knight) && piece_class.color == "white"
      return "♞"
    when piece_class.instance_of?(Bishop) && piece_class.color == "white"
      return "♝"
    when piece_class.instance_of?(Rook) && piece_class.color == "white"
      return "♜"
    when piece_class.instance_of?(Queen) && piece_class.color == "white"
      return "♛"
    when piece_class.instance_of?(King) && piece_class.color == "white"
      return "♚"
    when piece_class.instance_of?(Pawn) && piece_class.color == "black"
      return "♟"
    when piece_class.instance_of?(Knight) && piece_class.color == "black"
      return "♞"
    when piece_class.instance_of?(Bishop) && piece_class.color == "black"
      return "♝"
    when piece_class.instance_of?(Rook) && piece_class.color == "black"
      return "♜"
    when piece_class.instance_of?(Queen) && piece_class.color == "black"
      return "♛"
    when piece_class.instance_of?(King) && piece_class.color == "black"
      return "♚"
    else
      return " "
    end
  end
end

class Board
  include Displayable
  attr_accessor :board

  def initialize
    @board = [[nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil]]
  end

  def new_board
    #declaring the special white pieces
    @board[0][0] = Rook.new("white")
    @board[1][0] = Knight.new("white")
    @board[2][0] = Bishop.new("white")
    @board[3][0] = King.new("white")
    @board[4][0] = Queen.new("white")
    @board[5][0] = Bishop.new("white")
    @board[6][0] = Knight.new("white")
    @board[7][0] = Rook.new("white")

    #declaring the white pawns
    @board[0][1] = Pawn.new("white")
    @board[1][1] = Pawn.new("white")
    @board[2][1] = Pawn.new("white")
    @board[3][1] = Pawn.new("white")
    @board[4][1] = Pawn.new("white")
    @board[5][1] = Pawn.new("white")
    @board[6][1] = Pawn.new("white")
    @board[7][1] = Pawn.new("white")

    #declaring the special black pieces
    @board[0][7] = Rook.new("black")
    @board[1][7] = Knight.new("black")
    @board[2][7] = Bishop.new("black")
    @board[3][7] = King.new("black")
    @board[4][7] = Queen.new("black")
    @board[5][7] = Bishop.new("black")
    @board[6][7] = Knight.new("black")
    @board[7][7] = Rook.new("black")

    #declaring the black pawns
    @board[0][6] = Pawn.new("black")
    @board[1][6] = Pawn.new("black")
    @board[2][6] = Pawn.new("black")
    @board[3][6] = Pawn.new("black")
    @board[4][6] = Pawn.new("black")
    @board[5][6] = Pawn.new("black")
    @board[6][6] = Pawn.new("black")
    @board[7][6] = Pawn.new("black")
  end
end

board = Board.new
board.new_board
board.display_board(board.board)
# puts "\e[47m♙ \e[0m"
# puts "\e[42m♙ \e[0m"
# puts "\e[47;37m♟ \e[0m"
# puts "\e[42;30m♟ \e[0m"
