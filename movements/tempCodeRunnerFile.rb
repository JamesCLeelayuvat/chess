
board = Board.new
board.new_board
board.display_board(board.board)
prompts = Prompts.new
cm = Checking_Movements.new
focus = Focus.new
focus.white_focus = board.board[3][1]
p cm.is_pinned?([7, 7], "white", focus, board)
