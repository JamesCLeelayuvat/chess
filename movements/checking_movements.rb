require_relative "../Notation_Conversion.rb"
require_relative "../board.rb"
require_relative "../prompts.rb"
require_relative "focus.rb"
require_relative "../pieces/king.rb"
require_relative "basic_movement.rb"
require_relative "en_passant_movement.rb"

class Checking_Movements
  include Notation_Conversion

  def initialize
    @bm = Basic_Movement.new
    @epm = En_Passant.new
  end

  #returns an array of valid pawn moves, including captures
  def valid_moves_array_pawn(piece, board)
    column = piece.column
    row = piece.row
    valid_moves = []
    #double move
    if piece.color == "white"
      if piece.has_moved == false && row + 2 <= 7 && board[column][row + 1].nil? && board[column][row + 2].nil?
        valid_moves.append([column, row + 2])
      end
      if row + 1 <= 7 && board[column][row + 1].nil?
        valid_moves.append([column, row + 1])
      end
    else
      if piece.has_moved == false && row - 2 >= 0 && board[column][row - 1].nil? && board[column][row - 2].nil?
        valid_moves.append([column, row - 2])
      end
      if row - 1 >= 0 && board[column][row - 1].nil?
        valid_moves.append([column, row - 1])
      end
    end
    #check for captures
    if piece.color == "white"
      if row + 1 <= 7 && column + 1 <= 7 && !board[column + 1][row + 1].nil? && board[column + 1][row + 1].color != piece.color
        valid_moves.append([column + 1, row + 1])
      end
      if row + 1 <= 7 && column - 1 >= 0 && !board[column - 1][row + 1].nil? && board[column - 1][row + 1].color != piece.color
        valid_moves.append([column - 1, row + 1])
      end
    else
      if row - 1 >= 0 && column + 1 <= 7 && !board[column + 1][row - +1].nil? && board[column + 1][row - 1].color != piece.color
        valid_moves.append([column + 1, row + 1])
      end
      if row - 1 >= 0 && column - 1 >= 0 && !board[column - 1][row - 1].nil? && board[column - 1][row - 1].color != piece.color
        valid_moves.append([column - 1, row - 1])
      end
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
    while column + i <= 7
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

  #returns array of valid moves for king
  def valid_moves_array_king(piece, board, board_class)
    valid_moves = []
    #find the opposite color and grab list of pieces
    if piece.color == "white"
      opponent_pieces_array = board_class.black_pieces
    else
      opponent_pieces_array = board_class.white_pieces
    end
    danger_squares = []
    opponent_pieces_array.each { |piece|
      #append all moves by opponent to danger list
      if !piece.nil? && piece.captured == false
        if piece.instance_of? Pawn
          if piece.color == "white"
            if piece.column + 1 <= 7 && piece.row + 1 <= 7
              danger_squares.append([piece.column + 1, piece.row + 1])
            end
            if piece.column - 1 >= 0 && piece.row + 1 >= 0
              danger_squares.append([piece.column - 1, piece.row + 1])
            end
          else
            if piece.column + 1 <= 7 && piece.row - 1 >= 0
              danger_squares.append([piece.column + 1, piece.row - 1])
            end
            if piece.column - 1 >= 0 && piece.row - 1 >= 0
              danger_squares.append([piece.column - 1, piece.row - 1])
            end
          end
        elsif !piece.instance_of? King
          danger_squares += valid_moves_array(piece, board, board_class) unless valid_moves_array(piece, board, board_class).nil?
        end
      end
    }
    danger_squares.uniq!
    #checks all squares around king, adds to array of valid moves only if the square is not dangerous and no ally pieces are on the square
    for i in -1..1
      for j in -1..1
        if !danger_squares.include?([piece.column + i, piece.row + j]) && (piece.column + i).between?(0, 7) && (piece.row + j).between?(0, 7) && (board[piece.column + i][piece.row + j].nil? || board[piece.column + i][piece.row + j].color != piece.color)
          valid_moves.append([piece.column + i, piece.row + j])
        end
      end
    end
    valid_moves
  end

  #valid moves for all pieces
  def valid_basic_moves_array(piece, board, board_class)
    case
    when piece.instance_of?(Bishop)
      valid_moves_array_bishop(piece, board)
    when piece.instance_of?(Pawn)
      valid_moves_array_pawn(piece, board)
    when piece.instance_of?(Rook)
      valid_moves_array_rook(piece, board)
    when piece.instance_of?(Knight)
      valid_moves_array_knight(piece, board)
    when piece.instance_of?(King)
      valid_moves_array_king(piece, board, board_class)
    when piece.instance_of?(Queen)
      valid_moves_array_queen(piece, board)
    end
  end

  def danger_squares(color, board, board_class)
    if color == "white"
      opponent_pieces_array = board_class.black_pieces
    else
      opponent_pieces_array = board_class.white_pieces
    end
    danger_squares = []
    opponent_pieces_array.each do |piece|
      #append all moves by opponent to danger list
      if !piece.nil? && piece.captured == false
        if piece.instance_of? Pawn
          if piece.color == "white"
            if piece.column + 1 <= 7 && piece.row + 1 <= 7
              danger_squares.append([piece.column + 1, piece.row + 1])
            end
            if piece.column - 1 >= 0 && piece.row + 1 >= 0
              danger_squares.append([piece.column - 1, piece.row + 1])
            end
          else
            if piece.column + 1 <= 7 && piece.row - 1 >= 0
              danger_squares.append([piece.column + 1, piece.row - 1])
            end
            if piece.column - 1 >= 0 && piece.row - 1 >= 0
              danger_squares.append([piece.column - 1, piece.row - 1])
            end
          end
        elsif !piece.instance_of? King
          danger_squares += all_valid_moves_array_e(piece, board, board_class) unless all_valid_moves_array_e(piece, board, board_class).nil?
        end
      end
    end
    danger_squares.uniq!
  end

  def is_pinned?(move, color, focus, board)
    board_clone = Marshal.load(Marshal.dump(board.board))
    #determine the piece to be focused on to move
    if color == "white"
      focus_piece = board_clone[focus.white_focus.column][focus.white_focus.row]
    else
      focus_piece = board_clone[focus.black_focus.column][focus.white_focus.row]
    end
    #moving the clone piece
    board_clone[focus_piece.column][focus_piece.row] = nil
    focus_piece.column = move[0]
    focus_piece.row = move[1]
    if color == "white"
      king = board.white_pieces.select { |piece| piece.instance_of? King }
    else
      king = board.black_pieces.select { |piece| piece.instance_of? King }
    end
    danger_squares_array = danger_squares(color, board_clone, board)
    king = king[0]
    if danger_squares_array.include?([king.column, king.row])
      return true
    else
      return false
    end
  end

  #not tested
  def check?(color, board, board_class)
    #get own pieces
    if color == "white"
      pieces = board_class.white_pieces
    else
      pieces = board_class.black_pieces
    end
    # find own king
    king = pieces.select { |p| p.instance_of? King }[0]
    if danger_squares(color, board, board_class).include?([king.column, king.row])
      return true
    end
  end

  #not tested
  def move_gets_out_of_check?(color, move, focus, board_class)
    #get focus
    if color == "white"
      focus_piece = focus.white_focus
    else
      focus_piece = focus.black_focus
    end

    #clone everything
    board_clone = Marshal.load(Marshal.dump(board_class))
    focus_clone = Marshal.load(Marshal.dump(focus))
    if move == "EPR"
      @epm.move_en_passant_right(focus_clone, color, board_clone.board)
    elsif move == "EPL"
      @epm.move_en_passant_left(focus_clone, color, board_clone.board)
    end

    @bm.basic_move(move, color, focus, board_clone.board, board_clone)
    if check?(color, board_clone.board, board_clone)
      return false
    end
    return true
  end

  #change all_valid_moves_array to take the piece from focus and color,
  # runs it through the check? to see if the move has to get_out_of_check?
  # it generates the basic moves array and runs each through the is_pinned?
  # to see if it is valid
  #not tested
  #implement the pin

=begin
generate all valid moves including en passants castles (check for check)
check for check again and if checked, go through the moves and cut out moves that return false to gets_out_of_check?

=end
  def all_valid_moves_array_e(piece, board, board_class)
    all_valid_moves = []
    all_valid_moves = all_valid_moves + valid_basic_moves_array(piece, board, board_class)
    #add in en passant moves
    if piece.instance_of? Pawn
      if @epm.en_passant_right?(piece, board)
        all_valid_moves.append["EPR"]
      end
      if @epm.en_passant_left?(piece, board)
        all_valid_moves.append["EPL"]
      end
      #checking for check
      all_valid_moves.each do |move|
        if !move_gets_out_of_check?(color, move, focus, board_class)
          all_valid_moves.delete(move)
        end
      end
    elsif piece.instance_of? King
      if can_castle_left?(color, board_class)
        all_valid_moves.append("CL")
      end
      if can_castle_right?(color, board_class)
        all_valid_moves.append("CR")
      end
    end
  end

  def all_valid_moves_array(focus, color, board, board_class)
    if color == "white"
      piece = focus.white_focus
    else
      piece = focus.black_focus
    end
    all_valid_moves = []
    all_valid_moves = all_valid_moves + valid_basic_moves_array(piece, board, board_class)
    #add in en passant moves
    if piece.instance_of? Pawn
      if @epm.en_passant_right?(piece, board)
        all_valid_moves.append("EPR")
      end
      if @epm.en_passant_left?(piece, board)
        all_valid_moves.append("EPL")
      end
      #checking for check
      all_valid_moves.each do |move|
        if !move_gets_out_of_check?(color, move, focus, board_class)
          all_valid_moves.delete(move)
        end
      end
    elsif piece.instance_of? King
      if can_castle_left?(color, board_class)
        all_valid_moves.append("CL")
      end
      if can_castle_right?(color, board_class)
        all_valid_moves.append("CR")
      end
    end
  end
end
