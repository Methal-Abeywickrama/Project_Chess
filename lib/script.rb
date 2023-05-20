# frozen_string_literal: true
require_relative 'chess_pieces.rb'

# Represents a chess game board
class Board 

  def initialize
    # Initializes the rows of the board
    @board = {}
    @rows= Array.new(10)
    set_the_board
    print_board
    # @white_pieces = {
    #   'knight' =
    #   'rook' = 
    #   'bishop' =
    #   'king' =
    #   'queen' =
    #   'pawn'  =
    # }
  end

  # Sets up the initial configuration of the chess board
  def set_the_board
    # Sets labels for the columns
    @board[:labels] = [' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'j']
    # Sets the white pieces column
    @board[:white_pieces] = set_column('white', 1)
    # Sets the white pawns column
    @board[:white_pawns] = set_pawn_column('white', 2)
    # Set the empty columns
    @board[3] = set_empty_column(3)
    @board[4] = set_empty_column(4)
    @board[5] = set_empty_column(5)
    @board[6] = set_empty_column(6)
    # Sets the black pawns column
    @board[:black_pawns] = set_pawn_column('black', 7)
    # Sets the black pieces column
    @board[:black_pieces] = set_column('black', 8)
    # Sets the labels for the columns
    @rows[9] = [' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'j']
  end

  # Sets up a column with pieces of a given colour
  def set_column(colour, letter)
    column = []
    column[0] = letter
    column[1] = Rook.new(colour)
    column[2] = Knight.new(colour)
    column[3] = Bishop.new(colour)
    column[4] = Queen.new(colour)
    column[5] = King.new(colour)
    column[6] = Bishop.new(colour)
    column[7] = Knight.new(colour)
    column[8] = Rook.new(colour)
    column
  end

  # Sets up a column with pawns of a given colour
  def set_pawn_column(colour, letter)
    column = []
    column[0] = letter
    for i in 1..8 do
      column[i] = Pawn.new(colour)
    end
    column
  end

  # Sets up an empty column
  def set_empty_column(letter)
    column = []
    column[0] = letter
    for i in 1..8 do
      column[i] = Blank.new
    end
    column
  end

  # Returns a printable representation of a square
  def ppt(square)
    return square.chara unless square.is_a?(String) || square.is_a?(Integer)

    square
  end

  # Prints the current state of the chess board
  def print_board
    @board.each_with_index do |(key, value), n|
        puts '-------------------------------------'
        if key == :labels
          puts "| #{value.join(' | ')} |"
        else 
          puts "| #{ppt(value[0])} | #{ppt(value[1])} | #{ppt(value[2])} | #{ppt(value[3])} | #{ppt(value[4])} | #{ppt(value[5])} | #{ppt(value[6])} | #{ppt(value[7])} | #{ppt(value[8])} |"
        end
    end
    puts '-------------------------------------'
  end

  # Analyzes the user input and acts accordingly
  def analyze_input(input)
   if input == 'O-O' or '0-0'
      # then kingside castle
   elsif input == 'O-O-O' or '0-0-0'
      # then queenside castle
   elsif input.length == 4 && input.split(//)[1] == 'x'
      # then capture
   elsif input.length == 2 && input.split(//)[0].ord.between?(97, 122) && input.split(//)[1].ord.between?(49, 56)
      # then its a pawn movement
   elsif input.length == 3 && input.split(//)[1].ord.between?(97, 122) && input.split(//)[2].ord.between?(49, 56)
      # then its the movement of a different piece
   else
      # Its and invalid input
   end

  end
end

 game = Board.new

