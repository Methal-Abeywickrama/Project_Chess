# frozen_string_literal: true

# Contain the functionalities for standard movements that will be used in other classes.
module PieceMovements

  def move(previous_square, new_square)
    piece = @board[previous_square[0]][previous_square[1]]
    @board[new_square[0]][new_square[1]] = piece
    @board[previous_square[0]][previous_square[1]] = Blank.new
  end

  def say_hi(row, column, piece)
    puts "row #{row}"
    puts "column #{column}"
    p piece
  end

  def calculate_moves_each
    cycle_through_pieces(:say_hi)
  end

  # Calculates the possible moves that each piece can make without restrictions
  def cycle_through_pieces(func)
    @board.each do |row, value|
      next if [:labels, 9].include?(row)

        value.each_with_index do |item, column|
          next if [Blank, String].include?(item.class)

          method(func).call(row, column, item)
        end
    end
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
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      targetted_piece = false

      while valid_move?(next_position, piece.colour) && !targetted_piece
        piece.possible_moves.push(next_position)
        targetted_piece = target_acquired?(next_position)
        next_position = [next_position[0] + shift[0], next_position[1] + shift[1]]
      end
    end
  end

  # Calculates the possible moves for the knight
  def calculate_moves_knight(row, column, piece)
    transformations = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      if valid_move?(next_position, piece.colour)
        piece.possible_moves.push(next_position)
      end
    end
  end

  # Calculates the possible moves for the bishop
  def calculate_moves_bishop(row, column, piece)
    transformations = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      targetted_piece = false

      while valid_move?(next_position, piece.colour) && !targetted_piece
        piece.possible_moves.push(next_position)
        targetted_piece = target_acquired?(next_position)
        next_position = [next_position[0] + shift[0], next_position[1] + shift[1]]
      end
    end
  end

  # Calculates the possible moves for the queen
  def calculate_moves_queen(row, column, piece)
    transformations = [[1, 1], [-1, -1], [1, -1], [-1, 1], [1, 0], [0, 1], [-1, 0], [0, -1]]
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      targetted_piece = false

      while valid_move?(next_position, piece.colour) && !targetted_piece
        piece.possible_moves.push(next_position)
        targetted_piece = target_acquired?(next_position)
        next_position = [next_position[0] + shift[0], next_position[1] + shift[1]]
      end
    end
  end

  # Calculates the possible moves for the king
  def calculate_moves_king(row, column, piece)
    transformations = [[1, 1], [-1, -1], [1, -1], [-1, 1], [1, 0], [0, 1], [-1, 0], [0, -1]]
    transformations.each do |shift|
      current_position = [row, column]
      next_position = [current_position[0] + shift[0], current_position[1] + shift[1]]
      if valid_move?(next_position, piece.colour)
        piece.possible_moves.push(next_position)
      end
    end
  end

  # Calculates the possible moves for the pawn
  def calculate_moves_pawn(row, column, piece)
    current_position = [row, column]
    if row == 2 && piece.colour == 'white'
      piece.possible_moves.push([current_position[0] + 2, current_position[1]]) if valid_move_pawn?(current_position[0] + 2, current_position[1], 'white')
      piece.possible_moves.push([current_position[0] + 1, current_position[1]]) if valid_move_pawn?(current_position[0] + 1, current_position[1], 'white')
    elsif piece.colour == 'white' && valid_move_pawn?(current_position[0] + 1, current_position[1], 'white')
      piece.possible_moves.push([current_position[0] + 1, current_position[1]])
    elsif row == 7 && piece.colour == 'black'
      piece.possible_moves.push([current_position[0] - 2, current_position[1]]) if valid_move_pawn?(current_position[0] - 2, current_position[1], 'black')
      piece.possible_moves.push([current_position[0] - 1, current_position[1]]) if valid_move_pawn?(current_position[0] - 1, current_position[1], 'black')
    elsif piece.colour == 'black' && valid_move_pawn?(current_position[0] + 1, current_position[1], 'black')
      piece.possible_moves.push([current_position[0] + 1, current_position[1]])
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
    elsif @board[square[0]][square[1]].instance_of?(King)
      false
      @check = true
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


end
