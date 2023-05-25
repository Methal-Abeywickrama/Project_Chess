# frozen_string_literal: true

# This class contains the common behaviours that shall be implemented in the successive classes
class ChessPiece 

  @@
  def initialize

  end
end

class Rook
  attr_accessor :chara, :colour

  def initialize(colour)
    @colour = colour
    @square()
    @chara = @colour.eql?("black") ? "\u{265C}" : "\u{2656}"
    @moves_available = []
  end

  #Calculates the possible moves that each piece can make without restrictions
  def calculate_moves

  end
end

class Knight 
  attr_accessor :chara, :colour

  def initialize(colour)
    @colour = colour
    @chara = @colour.eql?("black") ? "\u{265E}" : "\u{2658}"
  end
end

class Bishop 
  attr_accessor :chara, :colour

  def initialize(colour)
    @colour = colour
    @chara = @colour.eql?("black") ? "\u{265D}" : "\u{2657}"
  end
end

class Queen 
  attr_accessor :chara, :colour

  def initialize(colour)
    @colour = colour
    @chara = @colour.eql?("black") ? "\u{265B}" : "\u{2655}"
  end
end

class King 
  attr_accessor :chara, :colour

  def initialize(colour)
    @colour = colour
    @chara = @colour.eql?("black") ? "\u{265A}" : "\u{2654}"
  end
end

class Pawn
  attr_accessor :chara, :colour

  def initialize(colour)
    @colour = colour
    @chara = @colour.eql?("black") ? "\u{265F}" : "\u{2659}"
  end
end

class Blank
  attr_accessor :chara
  
  def initialize
    @chara = " "
  end
end
