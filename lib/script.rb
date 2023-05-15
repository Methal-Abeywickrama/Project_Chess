# frozen_string_literal: true
require_relative 'chess_pieces.rb'

# Represents a chess game board
class Board 

  def initialize
    # Initializes the rows of the board
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
    @rows[0] = [' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'j']
    # Sets the white pieces column
    @rows[1] = set_column('white', 1)
    # Sets the white pawns column
    @rows[2] = set_pawn_column('white', 2)
    # Set the empty columns
    @rows[3] = set_empty_column(3)
    @rows[4] = set_empty_column(4)
    @rows[5] = set_empty_column(5)
    p @rows[5]
    @rows[6] = set_empty_column(6)
    # Sets the black pawns column
    @rows[7] = set_pawn_column('black', 7)
    # Sets the black pieces column
    @rows[8] = set_column('black', 8)
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
    @rows.each_with_index do |x, n|
      puts '-------------------------------------'
      puts "| #{ppt(x[0])} | #{ppt(x[1])} | #{ppt(x[2])} | #{ppt(x[3])} | #{ppt(x[4])} | #{ppt(x[5])} | #{ppt(x[6])} | #{ppt(x[7])} | #{ppt(x[8])} |"
    end
    puts '-------------------------------------'
  end

  def format_input(input)
   if input == 'O-O' or '0-0'
      # then kingside castle
   elsif input == 'O-O-O' or '0-0-0'
      #then queenside castle
   elsif input.length = 4 && input.split(//)[1] == 'x'
      #then capture
   elsif input
   end

  end
end

 game = Board.new

