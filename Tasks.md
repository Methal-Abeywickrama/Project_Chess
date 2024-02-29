To be defined:=


>> Castling function
>> Pawn promotion
>> Draws
    -- Repetition
    -- Stalemate
    --
>> find a suitable method to print a board when playing as black
>> change the unicode characters for black and white
>> A method to read standard notation and an alternative input cycle to obtain input from the standard notation
>> A suit of tests that can be given in standard notation
>> Serialization
##  >> write a way for each piece to know beforehand its possible moves
done, with the exception of pawn bypasses
## check architecture for pawns
## Checkmate
  When a check is triggered
  Cycle through all of the opponents pieces
    for each piece, for each move :-
      Create a duplicate temporary board
      Execute the move on the duplicate board
      Check for checks again
      If after any move, there is no check, return false, otherwise, checkmate = true

## Flow structure for the game
Creates the game board and the player profiles 

## Validity of user inputs


## def find_move_feasibility(move)
    <!-- # Case:01  start square, end square both the same color
    # Case:02  start square doesnt contain a piece
    # Case:03  start square doesnt contain a piece of the correct color
    # Case:04  out of the range of possible movements of the piece
    # Case:05  obstruction in the way -->
    # Case:06  the king comes into check
  end

## no checks exist
## define the superclass for the chess pieces
## Pawns have a problem containing common intial square
## Duplication of possible moves after each turn when the piece does not move
## Pawn captures

      ---Ongoing---


