# frozen_string_literal: true
require_relative 'chess_pieces.rb'

class Board 

  def initialize
    @rows= Array.new(10)
    set_the_board
    print_board
  end

  def set_the_board
    @rows[0] = [' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'j']
    @rows[1] = set_column('white', 1)
    @rows[2] = set_pawn_column('white', 2)
    @rows[3] = set_empty_column(3)
    @rows[4] = set_empty_column(4)
    @rows[5] = set_empty_column(5)
    @rows[6] = set_empty_column(6)
    @rows[7] = set_pawn_column('black', 7)
    @rows[8] = set_column('black', 8)
    @rows[9] = [' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'j']
  end

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

  def set_pawn_column(colour, letter)
    column = []
    column[0] = letter
    for i in 1..8 do
      column[i] = Pawn.new(colour)
    end
    column
  end

  def set_empty_column(letter)
    column = []
    column[0] = letter
    for i in 1..8 do
      column[i] = Blank.new
    end
    column
  end

  def ppt(square)
    square.chara if square.is_a?(String)
  end

  def print_board
    @rows.each_with_index do |x, n|
        puts '---------------------------------'
        puts "| #{ppt(x[0])} | #{ppt(x[1])} | #{ppt(x[2])} | #{ppt(x[3])} | #{ppt(x[4])} | #{ppt(x[5])} | #{ppt(x[6])} | #{ppt(x[7])} | #{ppt(x[8])} |"
    end
    puts '---------------------------------'
  end
end

game = Board.new


