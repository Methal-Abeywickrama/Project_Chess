# frozen_string_literal: true

require_relative 'chess_pieces'
require_relative 'board_setup'
require_relative 'user_input'
require_relative 'piece_movements'

# Represents a chess game board
class Board
  attr_accessor :board, :rows, :checkmate, :check

  include BoardSetup
  include UserInput
  include PieceMovements

  # Initializes the rows of the board
  def initialize
    @check = false
    @checkmate = false
    @board = {}
    set_the_board
    cycle_through_pieces(:calculate_possible_moves)

    # input = take_an_input

    print_board
    # calculate_possible_moves
  end

  # methods to be executed at the end of each turn
  def turn_end
    cycle_through_pieces(:calculate_possible_moves)
    p cycle_through_pieces_for_checks(:check_for_checks)
    print_board
  end

  # def print_pieces(row, column, piece)
  #   p piece.class
  #   p piece.colour

  # end
end

# Represents a human player
class Player
  attr_accessor :name

  def initialize(name, colour)
    @name = name
    @colour = colour
  end
end

# Flow structure ///////////

puts 'Lets play a game of chess'

game = Board.new
# game.print_squares_board
won = false

until won
  puts 'Player 1, enter your move'
  u_input = game.take_an_input('white')
  game.move(u_input[1], u_input[2])
  puts 'yodle ' if game.check
  game.turn_end
  
  puts 'Player 2, enter your move'
  u_input = game.take_an_input('black')
  p u_input
  game.move(u_input[1], u_input[2])
  puts 'yodle ' if game.check
  game.turn_end
  puts 'round'
end



