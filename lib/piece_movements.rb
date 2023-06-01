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
    puts "piece #{piece}"
  end

  # Calculates the possible moves that each piece can make without restrictions
  def cycle_through_pieces(func)
    @board.each do |row, value|
      next if [:labels, 9].include?(row)

        value.each_with_index do |item, column|
          next if [Blank, Integer].include?(item.class)

          method(func).call(row, column, value)
        end
    end
  end
end
