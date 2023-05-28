# frozen_string_literal: true

require_relative 'chess_pieces'
require_relative 'board_setup'
require_relative 'user_input'

# Represents a chess game board
class Board
  attr_accessor :board, :rows

  include BoardSetup
  include UserInput

  def initialize
    # Initializes the rows of the board
    @board = {}
    set_the_board
    print_board
    print_squares_board
    input = take_and_input
  end

end

game = Board.new


# game.board.print 

