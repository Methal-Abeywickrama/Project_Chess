# frozen_string_literal: true

class Chess_Piece
  def initialize(colour)
    @type
    @colour = colour
  end
end

class Rook < Chess_Piece
  def initialize
    super
    @type = 'Rook'
  end

end

class Knight < Chess_Piece
  def initialize
    super
    @type = 'Knight'
  end
end

class Bishop < Chess_Piece
  def initialize
    super
    @type = 'Bishop'
  end
end

class Queen < Chess_Piece
  def initialize
    super
    @type = 'Queen'
  end
end

class King < Chess_Piece
  def initialize
    super
    @type = 'King'
  end
end

class Pawn < Chess_Piece
  def initialize
    super
    @type = 'Pawn'
  end
end
