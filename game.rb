require_relative "board.rb"
require_relative "prompts.rb"
require_relative "./movements/focus.rb"
require_relative "./movements/basic_movement.rb"

class Game
  def initialize
    @board = Board.new
    @prompts = Prompts.new
    @focus = Focus.new
    p "hello"

    @bm = Basic_Movement.new
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
      @board.display_board_focus(@board.board)
      move = @prompts.get_move_to_selection
      @bm.basic_move(move, turn_color(turn_count), @focus, @board.board, @board)
      turn_count += 1
    end
    p "hello"
  end
end

game = Game.new
