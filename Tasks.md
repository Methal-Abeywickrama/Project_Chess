To be defined:=

>>Checkmate
  When a check is triggered
  Cycle through all of the opponents pieces
    for each piece, for each move :-
      Create a duplicate temporary board
      Execute the move on the duplicate board
      Check for checks again
      If after any move, there is no check, return false, otherwise, checkmate = true

>> Flow structure for the game
Creates the game board and the player profiles 

>> Validity of user inputs

>> check architecture for pawns

>> def find_move_feasibility(move)
    <!-- # Case:01  start square, end square both the same color
    # Case:02  start square doesnt contain a piece
    # Case:03  start square doesnt contain a piece of the correct color
    # Case:04  out of the range of possible movements of the piece
    # Case:05  obstruction in the way -->
    # Case:06  the king comes into check
  end

>> find a suitable method to print a board when playing as black
>> check with chatgpt why removing the brackets in print board fucks the method
>> change the unicode characters for black and white
##  >> write a way for each piece to know beforehand its possible moves
done, with the exception of pawn bypasses

## no checks exist
##  >> define the superclass for the chess pieces

      ---Ongoing---


