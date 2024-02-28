
  # Analyzes the user input and acts accordingly
  
def analyze_input(input)
  if input == 'O-O' or '0-0'
     # then kingside castle
  elsif input == 'O-O-O' or '0-0-0'
     # then queenside castle
  elsif input.length == 4 && input.split(//)[1] == 'x'
     # then capture
  elsif input.length == 2 && input.split(//)[0].ord.between?(97, 122) && input.split(//)[1].ord.between?(49, 56)
     # then its a pawn movement
  elsif input.length == 3 && input.split(//)[1].ord.between?(97, 122) && input.split(//)[2].ord.between?(49, 56)
     # then its the movement of a different piece
  else
     # Its and invalid input
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

