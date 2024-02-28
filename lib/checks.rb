# frozen_string_literal: true

module Checks

  def is_check?(moves, st_sq, end_sq, colour)
    return false if moves.empty?

    new_board = Board.new
    move_list = moves.dup
    until move_list.empty?
      new_board.move(move_list.shift, move_list.shift)
      new_board.cycle_through_pieces(:calculate_possible_moves)
    end
    new_board.move(st_sq, end_sq)
    new_board.cycle_through_pieces(:calculate_possible_moves)
    # new_board.print_board
    # new_board.print_pieces
    new_board.cycle_through_pieces_for_checks(:check_for_checks, new_board.board, colour)
    
  end

  # Check if the king is in check by a particular piece
  def check_for_checks(row, column, piece, board)
    return false if piece.instance_of?(King)

    check = false
    piece.possible_moves.each do |square|
      targetted_piece = board[square[1]][square[0]] unless board[square[1]][square[0]].instance_of?(Blank)
      if targetted_piece.instance_of?(King) && targetted_piece.colour != piece.colour
        return true 
      end
    end
    check
  end

  def checkmate?(moves, player_colour)
    new_board = Board.new
    move_list = moves.dup
    until move_list.empty?
      new_board.move(move_list.shift, move_list.shift)
      new_board.cycle_through_pieces(:calculate_possible_moves)
    end
    # new_board..cycle_through_pieces(:print_pieces)
    # new_board.print_board

    new_board.cycle_through_pieces3(:check_checkmate, player_colour, moves)
  end

  def check_checkmate(row, column, piece, moves)
    piece.possible_moves.each do |move|
      newer_board = Board.new
      move_list = moves.dup
      until move_list.empty?
        newer_board.move(move_list.shift, move_list.shift)
        newer_board.cycle_through_pieces(:calculate_possible_moves)
      end
      newer_board.move(piece.square, move)
      newer_board.cycle_through_pieces(:calculate_possible_moves)
      chek = newer_board.cycle_through_pieces_for_checks(:check_for_checks, newer_board.board, piece.colour)
      return false unless chek
    end
    true
  end

  # Cycles through each square to execute checkmate on them
  def cycle_through_pieces3(func, player_colour, moves)
    @board.each do |row, value|
      next if [:labels, 9].include?(row)

        value.each_with_index do |item, column|
          next if [Blank, String].include?(item.class) || item.colour == player_colour

          return false unless method(func).call(row, column, item, moves)
        end
    end
    true
  end
end