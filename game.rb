require_relative "board.rb"
require_relative "prompts.rb"
require_relative "./movements/focus.rb"
require_relative "./movements/basic_movement.rb"

class Game
  def initialize
    @board = Board.new
    @prompts = Prompts.new
    @focus = Focus.new
    @cm = Checking_Movements.new
    @bm = Basic_Movement.new
    @ep = En_Passant.new
  end

  def turn_color(num)
    if num % 2 == 0
      return "white"
    else
      return "black"
    end
  end

  def start_game
    @board.new_board
    win = false
    turn_count = 0

    while true
      @board.display_board(@board.board)
      #focus
      if turn_color(turn_count) == "white"
        @focus.white_focus = @prompts.get_focus_selection(turn_color, @board.board)
      else
        @focus.black_focus = @prompts.get_focus_selection(turn_color @board.board)
      end
      #change the basic movement to get the move wanted and execute it, use the all_valid_moves array to get all the moves
      #how to translate en passant to the letter code
      input_invalid = true
      #checkloop
      while (input_invalid)
        @board.display_board_focus(@board.board)
        move = @prompts.get_move_to_selection
        #creating all_valid_moves_array
        all_valid_moves_array = cm.all_valid_moves_array(@focus, turn_color(turn_count), @board.board, @board)
        #translate move to letter code if move is special

        if all_valid_moves_array.include?(move)
          #check if move is a special move
          #if move_is_a_castle or smth
          input_invalid = false
          if piece.instance_of? Pawn
            if move == "EPR"
              @ep.move_en_passant_right(@focus, turn_color(turn_count), @board.board)
            elsif move == "EPL"
              @ep.move_en_passant_right(@focus, turn_color(turn_count), @board.board)
            end
          elsif piece.instance_of? King
            # if move ==
          end
        end
      end
      @bm.basic_move(move, turn_color(turn_count), @focus, @board.board, @board)
      turn_count += 1
    end
  end
end

game = Game.new
game.start_game
