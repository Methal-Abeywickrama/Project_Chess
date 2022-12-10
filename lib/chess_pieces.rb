# frozen_string_literal: true

class Chess_Piece
  attr_accessor :chara, :possible_moves, :colour

  def initialize(colour)
    @colour = colour
 #   @possible_moves = calculate_moves()
    @chara = ' '
  end

  def 
end

class Rook < Chess_Piece
  def initialize
    super
    @type = 'rook'
    @chara = @colour.eql?('black') ? '\u265C' : '\u2656'
  end
end

class Knight < Chess_Piece
  def initialize
    super
    @type = 'knight'
    @chara = @colour.eql?('black') ? '\u265E' : '\u2658'
  end
end

class Bishop < Chess_Piece
  def initialize
    super
    @type = 'bishop'
    @chara = @colour.eql?('black') ? '\u265D' : '\u2657'
  end
end

class Queen < Chess_Piece
  def initialize
    super
    @type = 'queen'
    @chara = @colour.eql?('black') ? '\u265B' : '\u2655'
  end
end

class King < Chess_Piece
  def initialize
    super
    @type = 'king'
    @chara = @colour.eql?('black') ? '\u265A' : '\u2654'
  end
end

class Pawn < Chess_Piece
  def initialize
    super
    @type = 'pawn'
    @chara = @colour.eql?('black') ? '\u265F' : '\u2659'
  end
end

class Blank
  def intitialize
    @type = 'blank'
    @chara = ' '
  end
end
