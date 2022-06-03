board = Board.new
board.new_board
Focus.new
focus.white_focus = board.board[4][1]
display_board_focus(focus, "white", board.board)
