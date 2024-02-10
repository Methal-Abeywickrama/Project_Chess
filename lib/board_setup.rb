# frozen_string_literal: true

# Includes all the necessary methods for the intial setup of the board
module BoardSetup
# Sets up the initial configuration of the chess board
def set_the_board
  # Sets labels for the columns
  @board[:labels] = ['*', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
  # Sets the white pieces column
  @board[1] = set_column('white', '1')
  # Sets the white pawns column
  @board[2] = set_pawn_column('white', '2')
  # Set the empty columns
  @board[3] = set_empty_column('3')
  @board[4] = set_empty_column('4')
  @board[5] = set_empty_column('5')
  @board[6] = set_empty_column('6')
  # Sets the black pawns column
  @board[7] = set_pawn_column('black', '7')
  # Sets the black pieces column
  @board[8] = set_column('black', '8')
  # Sets the labels for the columns
  @board[9] = ['*', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
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
    # alphab = (96 + i).chr
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
  @board.each_with_index do |(key, value), n|
      puts '-------------------------------------'
      if key == :labels
        puts "| #{value.join(' | ')} |"
      else 
        puts "| #{ppt(value[0])} | #{ppt(value[1])} | #{ppt(value[2])} | #{ppt(value[3])} | #{ppt(value[4])} | #{ppt(value[5])} | #{ppt(value[6])} | #{ppt(value[7])} | #{ppt(value[8])} |"
      end
  end
  puts '-------------------------------------'
end

# Returns a printable representation of a postition of a square
def ppt_square(square)
  if square.is_a?(String) || square.is_a?(Integer)
    square
  elsif square.is_a?(Blank)
    "   #{square.chara}  "
  else
    square.square
  end
end

# Prints the current state of the chess board in terms of its square
def print_squares_board
  @board.each_with_index do |(key, value), n|
    puts "the key is"
    p key
    puts 'the value is'
    p value
    puts 'n is'
    p n
      puts '--------------------------------------------------------------------------'
      if key == :labels
        puts "| #{value.eql?('*') ? value.join(' | ') : value.join('  |  ')} |"
      else 
        puts "| #{ppt_square(value[0])} | #{ppt_square(value[1])} | #{ppt_square(value[2])} | #{ppt_square(value[3])} | #{ppt_square(value[4])} | #{ppt_square(value[5])} | #{ppt_square(value[6])} | #{ppt_square(value[7])} | #{ppt_square(value[8])} |"
      end
  end
  puts '--------------------------------------------------------------------------'
end

end