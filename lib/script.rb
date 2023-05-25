# frozen_string_literal: true

require_relative 'chess_pieces.rb'
require_relative 'board_setup.rb'

# Represents a chess game board
class Board
  attr_accessor :board, :rows

  include BoardSetup

  def initialize
    # Initializes the rows of the board
    @board = {}
    set_the_board
    print_board
  end

  # Analyzes the validity of format of a user input
  def squarewise_input_valid?(move)
    if move.length == 2 && move[0].ord.between?(97, 104) && move[1].ord.between?(49 , 56)
      true
    else
      false
    end
  end

  # Analyzes whether a certain move is possible on the board
  def find_move_feasibility(move)
    # Case:01  start square, end square both the same color
    # Case:02  start square doesnt contain a piece
    # Case:03  start square doesnt contain a piece of the correct color
    # Case:04  out of the range of possible movements of the piece
    # Case:05  obstruction in the way
    # Case:06  the king comes into check
  end

  # Gets the input of the user for a move
  def get_user_input(color, start_square = 'initial', final_square = 'initial')
    until squarewise_input_valid?(start_square)
      puts "Enter the square of the piece to be moved"
      start_square = gets.chomp!.chars
    end
    # ///////  check the validity
    until squarewise_input_valid?(final_square)
      puts "Enter the square to be moved into"
      final_square = get.chomp!.chars
    end
    # ///////  check the validity

    [start_square, final_square, color]
  end
  
end

game = Board.new


game.board.print 

