require_relative "board.rb"
require_relative "prompts.rb"
require_relative "./movements/focus.rb"
require_relative "./movements/basic_movement.rb"

class Game
  def initialize
    @board = Board.new
    @prompts = Prompts.new
    @focus = Focus.new
    @bm = Basic_Movement.new
    puts "test"
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
    unless win
      @board.display_board(@board.board)
      if turn_color(turn_count) == "white"
        @focus.white_focus = @prompts.get_focus_selection
      else
        @focus.black_focus = @prompts.get_focus_selection
      end
      move = @prompts.get_move_to_selection
      @bm.basic_move(move)
    end
  end
end

game = Game.new
game.start_game
