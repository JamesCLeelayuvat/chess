require_relative "../prompts.rb"

class Focus
  attr_accessor :white_focus, :black_focus

  def initialize
    @prompts = Prompts.new
    @white_focus = nil
    @black_focus = nil
  end

  #resetting focus
  def reset_focus
    @white_focus = nil
    @black_focus = nil
  end

  #get the piece selection from the player
  def get_focus(color, board)
    valid_focus = false
    unless valid_focus
      focus = @prompts.get_focus_selection
      if board[focus[0]][focus[1]].color == color
        valid_focus = true
        if color == "white"
          @white_focus = board[focus[0]][focus[1]]
        else
          @black_focus = board[focus[0]][focus[1]]
        end
      end
    end
  end
end
