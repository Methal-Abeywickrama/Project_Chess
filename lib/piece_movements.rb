# frozen_string_literal: true

# Contain the functionalities for standard movements that will be used in other classes.
module PieceMovements

  def move(previous_square, new_square, randoom = false)
    piece = @board[previous_square[0]][previous_square[1]]
    if randoom
      p piece
    end
    @board[new_square[0]][new_square[1]] = piece
    @board[new_square[0]][new_square[1]].square = new_square
    if randoom
      p @board[new_square[0]][new_square[1]]
    end
    @board[previous_square[0]][previous_square[1]] = Blank.new
    [previous_square, new_square]
  end

  def say_hi(row, column, piece)
    puts "row #{row}"
    puts "column #{column}"
    p piece
  end

  # Redundant method
  # def calculate_moves_each
  #   cycle_through_pieces(:say_hi)
  # end

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

  # Cycles through each square to return each pieces possible move
  def cycle_through_pieces_moves(func, colour)
    move_set = []
    @board.each do |row, value|
      next if [:labels, 9].include?(row)

        value.each_with_index do |item, column|
          next if [Blank, String].include?(item.class) || item.colour != colour

         move_set.push(method(func).call(row, column, item))
        end
    end
    move_set
  end

  # For each piece, returns a possible move until the possible moves run out
  def return_each_possible_move(row, column, piece)
    moves_list = piece.possible_moves.dup
    new_list = []
    moves_list.each do |move|
      new_list.push(piece.square) unless piece.square.nil?
      new_list.push(move) unless move.nil?
    end
    new_list
  end


  # Cycles through each square of the board to return pieces to check for checks
  def cycle_through_pieces_for_checks(func, board)
    board.each do |row, value|
      next if [:labels, 9].include?(row)

        value.each_with_index do |item, column|
          next if [Blank, String].include?(item.class)
 
          return true  if method(func).call(row, column, item, board)
        end
    end
    false
  end

  # Cycles through each square of the board to return pieces to check for checks
  def cycle_through_pieces_for_checks_within(func, board)
    puts 'im here'
    board.board.each do |row, value|
      next if [:labels, 9].include?(row)

        value.each_with_index do |item, column|
          next if [Blank, String].include?(item.class)
          # if method(func).call(row, column, item, board)
          #   p item
          #   puts 'the board in question'
          #   board.print_board
          # end
          return true if method(func).call(row, column, item, board)
          
        end
    end
    false
  end

  # Cycles through each square of the board to return pieces to check for checkmate
  def cycle_through_pieces_for_checkmate(colour)
    p 'here at 82'
    count = 0
    @board.each do |row, value|
      next if [:labels, 9].include?(row)
      
      value.each_with_index do |item, column|
        puts 'the value is '
        p item
        next if [Blank, String].include?(item.class) || item.colour != colour
        # if item.instance_of?(Bishop) 
        
        #   puts 'hi, is a bishop'
        #   p item.square
        #   p item.possible_moves
        # end
        item.possible_moves.each do |move|
          puts 'im in the method'
          new_move = [move[1], move[0]]
          new_board = Board.new(Marshal.load(Marshal.dump(@board)))
            # if count < 1 && row == 7 && column == 7 && new_move == [7, 6]
              puts ' new board is'
              p new_board.class
              puts 'piece is'
              p item

              puts 'new move is'
              p new_move
              new_board.print_board
              # new_board.board[row][column].chara = 'z'
              # new_board.print_board
              puts 'the new arrangement is'
              new_board.move([row, column], move)
              new_board.cycle_through_pieces(:calculate_possible_moves)
              new_board.print_board
              unless cycle_through_pieces_for_checks_within(:check_for_checks_within, new_board)
                puts 'yes, its false'
                return false
              end

              count += 1
            # end
            # if item.instance_of?(Bishop) && new_move == [5, 7]
            # puts 'previous board'
            # new_board.print_board
            # new_board.move([2,7], [2,6], true)
            # puts 'new board'
            # new_board.print_board
            # end

            # puts 'new board created'
            # puts 'piece is'
            # p item
            # puts 'move is'
            # p move
            # new_board.move(item.square, new_move)
            # # new_board.print_board
            # if item.instance_of?(Bishop) && new_move == [5, 7]
            #   puts 'conclusion'
            #   new_board.print_board
            # end
            # puts 'NO checkmate' unless cycle_through_pieces_for_checks(:check_for_checks)
            # return false unless cycle_through_pieces_for_checks(:check_for_checks)
          end
          # return false if method(func).call(row, column, item)
        end
    end
    true
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

  #Check if the king is in check by a particular piece
  def check_for_checks(row, column, piece, board)
    return false if piece.instance_of?(King)

    check = false
    piece.possible_moves.each do |square|
      targetted_piece = board[square[0]][square[1]] unless board[square[0]][square[1]].instance_of?(Blank)
      if targetted_piece.instance_of?(King) && targetted_piece.colour != piece.colour
        return true 
      end
    end
    check
  end

  #Check if the king is in check by a particular piece for new board
  def check_for_checks_within(row, column, piece, board)
    return false if piece.instance_of?(King)

    check = false
    piece.possible_moves.each do |square|
      targetted_piece = board.board[square[0]][square[1]] unless board.board[square[0]][square[1]].instance_of?(Blank)
      if piece.class == Queen && piece.colour == 'white' && square == [5, 7]
        puts 'queentime' 
        p piece
        
        p targetted_piece.instance_of?(King) && targetted_piece.colour != piece.colour
        p board.board[7][5]
        p board.board[2][5]
        p board.board[6][1]
        print_board
        p piece.colour
      end
      if targetted_piece.instance_of?(King) && targetted_piece.colour != piece.colour
        puts 'im in false'
        p piece
        return true 
      end
    end
    puts 'its here'
    check
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

  # Called in the even of a check to see if its checkmate
  def is_checkmate?(opponent_colour)
    cycle_through_pieces_for_checkmate(opponent_colour)
  end


end
