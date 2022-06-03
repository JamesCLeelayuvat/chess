require_relative "./pieces/bishop.rb"
require_relative "./pieces/king.rb"
require_relative "./pieces/knight.rb"
require_relative "./pieces/pawn.rb"
require_relative "./pieces/queen.rb"
require_relative "./pieces/rook.rb"
require_relative "./movements/focus.rb"
require_relative "./movements/checking_movements.rb"

module Displayable

  #print the top coordinates
  def print_top_coordinates
    puts "\e[0;33m a b c d e f g h\e[0m"
  end

  #returns the board rendered in unicode
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

  #input a class, returns the unicode symbol
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

  def display_board_focus(focus, color, board)
    cm = Checking_Movements.new
    print_top_coordinates
    board_visual = ""
    if color == "white"
      focus_piece = focus.white_focus
      valid_moves = cm.valid_moves_array(focus_piece, board.board, board)
    else
      focus_piece = focus.black_focus
      valid_moves = cm.valid_moves_array(focus_piece, board.board, board)
    end

    8.times do |i|
      k = 7 - i
      board_visual += "\e[0;33m#{k + 1}\e[0m"
      8.times do |j|
        if !board.board[j][k].nil? && valid_moves.include?([j, k])
          board_visual += "\e[43#{get_color_from_class(board.board[j][k])}m#{get_symbol_from_class(board.board[j][k])} \e[0m"
        elsif board.board[j][k].nil? && valid_moves.include?([j, k]) && (k + j) % 2 == 1
          board_visual += "\e[47;31m\u25CF \e[0m"
        elsif board.board[j][k].nil? && valid_moves.include?([j, k])
          board_visual += "\e[42;31m\u25CF \e[0m"
        elsif (k + j) % 2 == 1
          board_visual += "\e[47#{get_color_from_class(board.board[j][k])}m#{get_symbol_from_class(board.board[j][k])} \e[0m"
        else
          board_visual += "\e[42#{get_color_from_class(board.board[j][k])}m#{get_symbol_from_class(board.board[j][k])} \e[0m"
        end
      end
      board_visual += "\n"
    end
    puts board_visual
  end
end

class Board
  include Displayable
  attr_accessor :board, :white_pieces, :black_pieces

  def initialize
    @white_pieces = []
    @black_pieces = []
    @board = [[nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil]]
  end

  def self
    self
  end

  # creating a new board
  def new_board
    #declaring the special white pieces
    @board[0][0] = Rook.new("white", 0, 0)
    @board[1][0] = Knight.new("white", 1, 0)
    @board[2][0] = Bishop.new("white", 2, 0)
    @board[3][0] = Queen.new("white", 3, 0)
    @board[4][0] = King.new("white", 4, 0)
    @board[5][0] = Bishop.new("white", 5, 0)
    @board[6][0] = Knight.new("white", 6, 0)
    @board[7][0] = Rook.new("white", 7, 0)

    #declaring the white pawns
    @board[0][1] = Pawn.new("white", 0, 1)
    @board[1][1] = Pawn.new("white", 1, 1)
    @board[2][1] = Pawn.new("white", 2, 1)
    @board[3][1] = Pawn.new("white", 3, 1)
    @board[4][1] = Pawn.new("white", 4, 1)
    @board[5][1] = Pawn.new("white", 5, 1)
    @board[6][1] = Pawn.new("white", 6, 1)
    @board[7][1] = Pawn.new("white", 7, 1)
    #creating a list of all white pieces
    @board.each_with_index { |v, i|
      @white_pieces.append(@board[i][0])
      @white_pieces.append(@board[i][1])
    }

    #declaring the special black pieces
    @board[0][7] = Rook.new("black", 0, 7)
    @board[1][7] = Knight.new("black", 1, 7)
    @board[2][7] = Bishop.new("black", 2, 7)
    @board[3][7] = Queen.new("black", 3, 7)
    @board[4][7] = King.new("black", 4, 7)
    @board[5][7] = Bishop.new("black", 5, 7)
    @board[6][7] = Knight.new("black", 6, 7)
    @board[7][7] = Rook.new("black", 7, 7)

    #declaring the black pawns
    @board[0][6] = Pawn.new("black", 0, 6)
    @board[1][6] = Pawn.new("black", 1, 6)
    @board[2][6] = Pawn.new("black", 2, 6)
    @board[3][6] = Pawn.new("black", 3, 6)
    @board[4][6] = Pawn.new("black", 4, 6)
    @board[5][6] = Pawn.new("black", 5, 6)
    @board[6][6] = Pawn.new("black", 6, 6)
    @board[7][6] = Pawn.new("black", 7, 6)
    #creating a list of all black pieces
    @board.each_with_index { |v, i|
      @black_pieces.append(@board[i][6])
      @black_pieces.append(@board[i][7])
    }
  end
end

# board = Board.new
# board.new_board
# Focus.new
# focus.white_focus = board.board[4][1]
# display_board_focus(focus, "white", board.board)
