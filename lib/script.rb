# frozen_string_literal: true

require_relative 'chess_pieces'
require_relative 'board_setup'
require_relative 'user_input'
require_relative 'piece_movements'
require_relative 'checks'

# Represents a chess game board
class Board
  attr_accessor :board, :rows, :checkmate, :check

  include BoardSetup
  include UserInput
  include PieceMovements
  include Checks

  # Initializes the rows of the board
  def initialize(board = {})
    @check = false
    @checkmate = false
    @board = board
    set_the_board if @board.empty?
    cycle_through_pieces(:calculate_possible_moves)

    # input = take_an_input

    # print_board
    # calculate_possible_moves
  end

  # methods to be executed at the end of each turn
  def turn_end(player, opponent, game, moves)
    cycle_through_pieces(:calculate_possible_moves)
    opponent.check = cycle_through_pieces_for_checks(:check_for_checks)
    p opponent.check
    if game.board[7][5].instance_of?(King)
      puts 'gyrados'
    end
    if opponent.check
      mated = true
      puts 'reached here'
      new_game = Board.new
      new_moves = moves.dup
      until new_moves.empty?
        move_input = new_moves.shift
        new_game.move(move_input[1], move_input[2])
      end
      possibilities = new_game.cycle_through_pieces_moves(:return_each_possible_move, opponent.colour)
      p possibilities
      while mated && !possibilities.empty?
        new_game.move(possibilities.shift, possibilities.shift)
        mated = new_game.cycle_through_pieces_for_checks(:check_for_checks)
        new_game = Board.new
        new_moves = moves.dup
        until new_moves.empty?
          move_input = new_moves.shift
          new_game.move(move_input[1], move_input[2])
        end
      end

      if mated
        puts 'mated'
      else 
        puts 'not mated'
      end
      #  




      # if is_checkmate?(opponent.colour)
      #   puts 'iits a checkmate'
      # else
      #   puts 'ints not checkmate'
      # end
    end
    print_board
  end

  # def print_pieces(row, column, piece)
  #   p piece.class
  #   p piece.colour

  # end
end

# Represents a human player
class Player
  attr_accessor :name, :colour, :check

  def initialize(name, colour)
    @name = name
    @colour = colour
    @check = false
  end
end

# Flow structure ///////////

puts 'Lets play a game of chess'

player1 = Player.new('Player 1', 'white')
player2 = Player.new('Player 2', 'black')

game = Board.new
game.print_board
moves = []
# puts game.board
won = false

until won
  puts "#{player1.name}, enter your move"
  u_input = game.take_an_input('white', moves)
  p u_input
  moves game.move(u_input[1], u_input[2])
  game.turn_end(player1, player2, game, moves.dup)
  # won = game.is_checkmate?
  next if won
  
  puts "#{player2.name}, enter your move"
  u_input = game.take_an_input('black', moves)
  p u_input
  moves + game.move(u_input[1], u_input[2])
  game.turn_end(player2, player1, game, moves.dup)
  # won = game.is_checkmate?
  puts 'round'
end

# just_checks = ['e2', 'e4', 'f7', 'f5', 'd1', 'h5']
# checkmates = ['e2', 'e4', 'e7', 'e5', 'd1', 'h5', 'e8', 'e5', 'h5', 'e5']
# until won
#   puts "#{player1.name}, enter your move"
#   u_input = game.take_an_input('white', just_checks.shift, just_checks.shift)
#   game.move(u_input[1], u_input[2])
#   game.turn_end(player1, player2)
#   # won = game.is_checkmate?
#   next if won
  
#   puts "#{player2.name}, enter your move"
#   u_input = game.take_an_input('black', just_checks.shift, just_checks.shift)
#   # u_input = game.take_an_input('black')
#   p u_input
#   game.move(u_input[1], u_input[2])
#   game.turn_end(player2, player1)
#   # won = game.is_checkmate?
#   puts 'round'
# end



