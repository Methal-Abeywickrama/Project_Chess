
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