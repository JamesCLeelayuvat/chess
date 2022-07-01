 # if focus_piece.instance_of?(Pawn) && move[0] == focus_piece.row + 2
        #   @ep.pawn_double_moved = focus_piece
        # elsif focus_piece.instance_of?(Pawn) && !@ep.en_passant_to_letter_code(focus_piece, move, @board.board).nil? #bugged
        #   move = @ep.en_passant_to_letter_code(focus_piece, move, @board.board)
        #   @ep.pawn_double_moved = "none"
        # elsif focus_piece.instance_of?(King) && !@ctm.castle_to_letter_code(color, move, @board)
        #   move = @ctm.castle_to_letter_code(color, move, @board)
        # end