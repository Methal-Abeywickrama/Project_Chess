# frozen_string_literal: true

# Includes all the methods related to taking and verifying an input from a user
module UserInput
  def take_an_input(colour, moves)
    input = get_user_input(colour, moves)
    print input
    input
  end

  # Analyzes the validity of format of a user input
  def squarewise_input_valid?(move)
    if move.length == 2 && move[0].ord.between?(97, 104) && move[1].ord.between?(49 , 56)
      true
    else
      false
    end
  end

  # Analyzes whether a certain move is possible on the board
  def find_move_feasibility(move)
    # Case:01  start square, end square both the same color
    # Case:02  start square doesnt contain a piece
    # Case:03  start square doesnt contain a piece of the correct color
    # Case:04  out of the range of possible movements of the piece
    # Case:05  obstruction in the way
    # Case:06  the king comes into check
  end

  # Gets the input of the user for a move
  def get_user_input(color, moves)
    valid_move_found = false
    until valid_move_found
      start_square = 'initial'
      final_square = 'initial'
      until squarewise_input_valid?(start_square)
        puts 'Enter the square of the piece to be moved'
        start_square = gets.chomp!.chars unless squarewise_input_valid?(start_square)
      end
      # ///////  check the validity
      until squarewise_input_valid?(final_square) && final_square != start_square
        puts 'Enter the square to be moved into'
        final_square = gets.chomp!.chars 
      end
      # ///////  check the validity
      st_sq = convert_input_to_standard(start_square)
      end_sq = convert_input_to_standard(final_square)
      if @board[st_sq[0]][st_sq[1]].instance_of?(Blank) || @board[st_sq[0]][st_sq[1]].colour != color
        valid_move_found = false
        puts 'wrong colour dumbass'
      elsif @board[st_sq[0]][st_sq[1]].possible_moves.include?(end_sq)
        valid_move_found = true
      elsif is_check?(moves, st_sq, end_sq)
        puts 'Illegal move '

        valid_move_found = false
      else
        valid_move_found = false
      end
    end
    [color, st_sq, end_sq]
  end

  def convert_input_to_standard(square)
    square_output = []
    reference = { 'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5, 'f' => 6, 'g' => 7, 'h' => 8 }
    square_output[1] = reference[square[0]]
    square_output[0] = square[1].to_i
    square_output
  end

end