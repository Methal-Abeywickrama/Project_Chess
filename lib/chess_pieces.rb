# frozen_string_literal: true

require_relative 'piece_movements'

# This class contains the common behaviours that shall be implemented in the successive classes
class ChessPiece
  attr_accessor :colour

  def initialize(colour)
    @colour = colour
  end

  # Returns the initial position taking input as the colour
  def initial_square(start_pos)
    if @colour == 'white'
      start_pos[0]
    else
      start_pos[1]
    end
  end
end

# This class represents the rook
class Rook < ChessPiece
  include PieceMovements

  attr_accessor :square, :colour, :chara, :possible_moves

  @@count = {'white' => 0, 'black' => 0}
  @@initial_squares = { 'white' => [[1, 1], [8, 1]], 'black' => [[1, 8], [8, 8]] }
  @@transformations = [[0, 1], [1, 0], [-1, 0], [0, -1]]

  def initialize(colour)
    super(colour)
    @possible_moves = []
    @@count[colour] += 1
    @square = @@initial_squares[colour][@@count[colour] - 1]
    @chara = @colour.eql?("black") ? "\u{265C}" : "\u{2656}"
    # @possible_moves = calculate_moves_rook(@square[0], @square[1], colour)
  end

  # # Calculates the possible moves that each piece can make without restrictions
  # def calculate_moves
  #   @@transformations.each do |shift|

  #   end
  # end

end

# This class represents the rook
class Knight < ChessPiece
  attr_accessor :chara, :colour, :square, :possible_moves

  @@count = {'white' => 0, 'black' => 0}
  @@initial_squares = { 'white' => [[2, 1], [7, 1]], 'black' => [[2, 8], [7, 8]] }

  def initialize(colour)
    super(colour)
    @possible_moves = []
    @@count[colour] += 1
    @square = @@initial_squares[colour][@@count[colour] - 1]
    @chara = @colour.eql?("black") ? "\u{265E}" : "\u{2658}"
  end
end

# This class represents the Bishop
class Bishop < ChessPiece
  attr_accessor :chara, :colour, :square, :possible_moves

  @@count = {'white' => 0, 'black' => 0}
  @@initial_squares = { 'white' => [[3, 1], [6, 1]], 'black' => [[3, 8], [6, 8]] }

  def initialize(colour)
    super(colour)
    @possible_moves = []
    @@count[colour] += 1
    @square = @@initial_squares[colour][@@count[colour] - 1]
    @chara = @colour.eql?("black") ? "\u{265D}" : "\u{2657}"
  end
end

# This class represents the Queen
class Queen < ChessPiece
  attr_accessor :chara, :colour, :square, :possible_moves

  @@count = {'white' => 0, 'black' => 0}
  @@initial_squares = { 'white' => [[4, 1]], 'black' => [[4, 8]] }

  def initialize(colour)
    super(colour)
    @possible_moves = []
    @@count[colour] += 1
    @square = @@initial_squares[colour][@@count[colour] - 1]
    @chara = @colour.eql?("black") ? "\u{265B}" : "\u{2655}"
  end
end

# This class represents the King
class King < ChessPiece
  attr_accessor :chara, :colour, :square, :possible_moves

  @@count = {'white' => 0, 'black' => 0}
  @@initial_squares = { 'white' => [[5, 1]], 'black' => [[5, 8]] }

  def initialize(colour)
    super(colour)
    @possible_moves = []
    @@count[colour] += 1
    @square = @@initial_squares[colour][@@count[colour] - 1]
    @chara = @colour.eql?("black") ? "\u{265A}" : "\u{2654}"
  end
end

# This class represents the Pawn
class Pawn < ChessPiece
  attr_accessor :chara, :colour, :square, :possible_moves

  @@count = {'white' => 0, 'black' => 0}
  @@initial_squares = { 'white' => [[1, 2], [2, 2], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2], [8, 2]],
                        'black' => [[1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7], [8, 7]] }

  def initialize(colour)
    super(colour)
    @possible_moves = []
    @@count[colour] += 1
    @square = @@initial_squares[colour][@@count[colour] - 1]
    @chara = @colour.eql?("black") ? "\u{265F}" : "\u{2659}"
  end
end

# This class represents an empty space on the board
class Blank 
  attr_accessor :chara
  
  def initialize
    @chara = " "
  end
end
