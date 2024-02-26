# frozen_string_literal: true

module Checks

  def is_check?(moves)
    return false if moves.empty?

    new_board = Board.new
    until moves.empty?
      new_board.move(moves.shift, moves.shift)
    end
    
  end
end