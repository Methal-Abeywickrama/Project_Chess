# frozen_string_literal: true

module Checks

  def is_check?(moves, st_sq, end_sq)
    return false if moves.empty?

    new_board = Board.new
    until moves.empty?
      new_board.move(moves.shift, moves.shift)
      new_board.cycle_through_pieces(:calculate_possible_moves)
    end
    new_board.move(st_sq, end_sq)
    new_board.cycle_through_pieces(:calculate_possible_moves)
    new_board.cycle_through_pieces_for_checks(:check_for_checks, new_board.board)

  end
end