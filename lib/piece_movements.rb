# frozen_string_literal: true

# Contain the functionalities for standard movements that will be used in other classes.
module PieceMovements

  # When a request to move a piece is given, checks the type of movement and executes the relevant one
  def initiate_movement(previous_square, next_square)
    # cycle_through_pieces(:print_pieces)
    if is_castle?(previous_square, next_square)
      castle(previous_square, next_square)
    else  
      move(previous_square, next_square)
    end
  end

  # Executes a castle
  def castle(previous_square, new_square)
    piece = @board[previous_square[1]][previous_square[0]]

    @board[new_square[1]][new_square[0]] = piece
    @board[new_square[1]][new_square[0]].square = new_square
    @board[previous_square[1]][previous_square[0]] = Blank.new
    case [piece.colour, previous_square, new_square]
    when ['white', [5, 1], [7, 1]]
      piece = @board[1][8]
      @board[1][6] = piece
      @board[1][6].square = [6, 1]
      @board[1][8] = Blank.new
    when ['white', [5, 1], [3, 1]]
      piece = @board[1][1]
      @board[1][4] = piece
      @board[1][4].square = [4, 1]
      @board[1][1] = Blank.new
    when ['black', [5, 8], [7, 8]]
      piece = @board[8][8]
      @board[8][6] = piece
      @board[8][6].square = [6, 8]
      @board[8][8] = Blank.new
    when ['black', [5, 8], [3, 8]]
      piece = @board[8][1]
      @board[8][4] = piece
      @board[8][4].square = [4, 8]
      @board[8][1] = Blank.new
    end
    print_board
    [previous_square, new_square]
  end

  # Makes a normal movement of a piece
  def move(previous_square, new_square)
    piece = @board[previous_square[1]][previous_square[0]]
    if piece.is_a?(King) || piece.is_a?(Rook)
      puts 'i moved'
      piece.moved = true
    end

    @board[new_square[1]][new_square[0]] = piece
    @board[new_square[1]][new_square[0]].square = new_square
 
    @board[previous_square[1]][previous_square[0]] = Blank.new
    [previous_square, new_square]
  end

  def say_hi(row, column, piece)
    puts "row #{row}"
    puts "column #{column}"
    p piece
  end

  # Cycles through each square to return the pieces to execute methods for them. Returns the board
  def cycle_through_pieces(func)
    @board.each do |row, value|
      next if [:labels, 9].include?(row)

        value.each_with_index do |item, column|
          next if [Blank, String].include?(item.class)

          method(func).call(row, column, item)
        end
    end
  end

  # Cycles through each square of the board to return pieces to check for checks
  def cycle_through_pieces_for_checks(func, board, colour)
    board.each do |row, value|
      next if [:labels, 9].include?(row)

        value.each_with_index do |item, column|
          next if [Blank, String].include?(item.class) || item.colour == colour 
 
          return true  if method(func).call(row, column, item, board)
        end
    end
    false
  end

  # Calls the relevant method on each piece to calculate its possible moves
  def calculate_possible_moves(row, column, piece)
    type = piece.class.to_s
    case type
    when 'Rook'
      calculate_moves_rook(row, column, piece)
    when 'Knight'
      calculate_moves_knight(row, column, piece)
    when 'Bishop'
      calculate_moves_bishop(row, column, piece)
    when 'Queen'
      calculate_moves_queen(row, column, piece)
    when 'King'
      calculate_moves_king(row, column, piece)
    when 'Pawn'
      calculate_moves_pawn(row, column, piece)
    end
  end

  # Calculates the possible moves for the rook
  def calculate_moves_rook(row, column, piece)
    transformations = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    piece.possible_moves = []
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      targetted_piece = false

      while valid_move?(next_position, piece.colour) && !targetted_piece
        piece.possible_moves.push(next_position.reverse)
        targetted_piece = target_acquired?(next_position)
        next_position = [next_position[0] + shift[0], next_position[1] + shift[1]]
      end
    end
  end

  # Calculates the possible moves for the knight
  def calculate_moves_knight(row, column, piece)
    transformations = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    piece.possible_moves = []
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      if valid_move?(next_position, piece.colour)
        piece.possible_moves.push(next_position.reverse)
      end
    end
  end

  # Calculates the possible moves for the bishop
  def calculate_moves_bishop(row, column, piece)
    transformations = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    piece.possible_moves = []
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      targetted_piece = false

      while valid_move?(next_position, piece.colour) && !targetted_piece
        piece.possible_moves.push(next_position.reverse)
        targetted_piece = target_acquired?(next_position)
        next_position = [next_position[0] + shift[0], next_position[1] + shift[1]]
      end
    end
  end

  # Calculates the possible moves for the queen
  def calculate_moves_queen(row, column, piece)
    transformations = [[1, 1], [-1, -1], [1, -1], [-1, 1], [1, 0], [0, 1], [-1, 0], [0, -1]]
    piece.possible_moves = []
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      targetted_piece = false

      while valid_move?(next_position, piece.colour) && !targetted_piece
        piece.possible_moves.push(next_position.reverse)
        targetted_piece = target_acquired?(next_position)
        next_position = [next_position[0] + shift[0], next_position[1] + shift[1]]
      end
    end
  end

  # Calculates the possible moves for the king
  def calculate_moves_king(row, column, piece)
    transformations = [[1, 1], [-1, -1], [1, -1], [-1, 1], [1, 0], [0, 1], [-1, 0], [0, -1]]
    piece.possible_moves = []
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      if valid_move?(next_position, piece.colour)
        piece.possible_moves.push(next_position.reverse)
      end
    end
    if piece.colour == 'white' && !(piece.moved) && @board[1][1].is_a?(Rook) && !(@board[1][1].moved)
      if @board[1][2].instance_of?(Blank) && @board[1][3].instance_of?(Blank) && @board[1][4].instance_of?(Blank)
        piece.possible_moves.push([3, 1])
      end
    end
    if piece.colour == 'white' && !(piece.moved) && @board[1][8].is_a?(Rook) && !(@board[1][8].moved)
      if @board[1][6].instance_of?(Blank) && @board[1][7].instance_of?(Blank) 
        piece.possible_moves.push([7, 1])
      end
    end
    if piece.colour == 'black' && !(piece.moved) && @board[8][1].is_a?(Rook) && !(@board[8][1].moved)
      if @board[8][2].instance_of?(Blank) && @board[8][3].instance_of?(Blank) && @board[8][4].instance_of?(Blank)
        piece.possible_moves.push([3, 8])
      end
    end
    if piece.colour == 'black' && !(piece.moved) && @board[8][8].is_a?(Rook) && !(@board[8][8].moved)
      if @board[8][6].instance_of?(Blank) && @board[8][7].instance_of?(Blank) 
        piece.possible_moves.push([7, 8])
      end
    end
  end

  # Calculates the possible moves for the pawn
  def calculate_moves_pawn(row, column, piece)
    current_position = [row, column]
    piece.possible_moves = []

    if row == 2 && piece.colour == 'white'
      piece.possible_moves.push([current_position[1], current_position[0] + 2]) if valid_move_pawn?(current_position[0] + 2, current_position[1], 'white')
      piece.possible_moves.push([current_position[1], current_position[0] + 1]) if valid_move_pawn?(current_position[0] + 1, current_position[1], 'white')
      # white pawn capture
      if @board[row+1][column+1].is_a?(ChessPiece) && @board[row+1][column+1].colour != piece.colour
        piece.possible_moves.push([current_position[1] + 1, current_position[0] + 1])
      elsif @board[row+1][column-1].is_a?(ChessPiece) && @board[row+1][column-1].colour != piece.colour
        piece.possible_moves.push([current_position[1] - 1, current_position[0] + 1])
      end
    elsif piece.colour == 'white' 
      if valid_move_pawn?(current_position[0] + 1, current_position[1], 'white')
        piece.possible_moves.push([current_position[1], current_position[0] + 1])
      end
      # white pawn capture
      if @board[row+1][column+1].is_a?(ChessPiece) && @board[row+1][column+1].colour != piece.colour
        piece.possible_moves.push([current_position[1] + 1, current_position[0] + 1])
      elsif @board[row+1][column-1].is_a?(ChessPiece) && @board[row+1][column-1].colour != piece.colour
        piece.possible_moves.push([current_position[1] - 1, current_position[0] + 1])
      end
    elsif row == 7 && piece.colour == 'black'
      piece.possible_moves.push([current_position[1], current_position[0] - 2]) if valid_move_pawn?(current_position[0] - 2, current_position[1], 'black')
      piece.possible_moves.push([current_position[1], current_position[0] - 1]) if valid_move_pawn?(current_position[0] - 1, current_position[1], 'black')
      # black pawn capture
      if @board[row-1][column+1].is_a?(ChessPiece) && @board[row-1][column+1].colour != piece.colour
        piece.possible_moves.push([current_position[1] + 1, current_position[0] - 1])
      elsif @board[row-1][column-1].is_a?(ChessPiece) && @board[row-1][column-1].colour != piece.colour
        piece.possible_moves.push([current_position[1] - 1, current_position[0] - 1])
      end
    elsif piece.colour == 'black' 
      if valid_move_pawn?(current_position[0] - 1, current_position[1], 'black')
        piece.possible_moves.push([current_position[1], current_position[0] - 1])
      end
      # black pawn capture
      if @board[row-1][column+1].is_a?(ChessPiece) && @board[row-1][column+1].colour != piece.colour
        piece.possible_moves.push([current_position[1] + 1, current_position[0] - 1])
      elsif @board[row-1][column-1].is_a?(ChessPiece) && @board[row-1][column-1].colour != piece.colour
        piece.possible_moves.push([current_position[1] - 1, current_position[0] - 1])
      end
    end

  end

  # Check the validity of a certain standard move for a pawn
  def valid_move_pawn?(row, column, colour='any')
    if !(row.between?(1, 8) && column.between?(1, 8))
      false
    elsif !(@board[row][column].instance_of?(Blank))
      false
    else
      true
    end
  end

  # Checks whether a certain piece has reached the end of the possible spaces to go along a row or a diagonal.
  def target_acquired?(square)
    return true unless @board[square[0]][square[1]].instance_of?(Blank)

    false
  end

  # Check the validity of a certain standard move for different pieces
  def valid_move?(square, colour)
    if !(square[0].between?(1, 8) && square[1].between?(1, 8))
      false
    elsif @board[square[0]][square[1]].instance_of?(King) && @board[square[0]][square[1]].colour == colour
      false
    elsif @board[square[0]][square[1]].instance_of?(String) 
      false
    elsif @board[square[0]][square[1]].instance_of?(Blank)
      true
    elsif @board[square[0]][square[1]].colour == colour
      false
    else 
      true
    end
  end

  # Detect a request for castling
  def is_castle?(previous_square, next_square)
    puts 'came here'
    piece = @board[previous_square[1]][previous_square[0]]
    pattern = [piece.colour, previous_square, next_square]
    patterns = [['black', [5, 8], [7, 8]], ['black', [5, 8], [3, 8]],
                ['white', [5, 1], [7, 1]], ['white', [5, 1], [3, 1]]]
    p piece
    p pattern
    puts piece.is_a?(King)
    puts !piece.moved if piece.is_a?(King)
    puts patterns.include?(pattern)
    if piece.is_a?(King) && !piece.moved && patterns.include?(pattern)
      true
    else  
      false 
    end
  end
end
