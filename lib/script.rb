# frozen_string_literal: true

require_relative 'chess_pieces'
require_relative 'board_setup'
require_relative 'user_input'
require_relative 'piece_movements'

# Represents a chess game board
class Board
  attr_accessor :board, :rows

  include BoardSetup
  include UserInput
  include PieceMovements

  # Initializes the rows of the board
  def initialize
    @board = {}
    set_the_board
    cycle_through_pieces(:calculate_possible_moves)
    # input = take_and_input

    move([2, 2], [9, 2])
    print_board
    # calculate_possible_moves
  end
end

game = Board.new



