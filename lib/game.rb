require './lib/board'
require './lib/player'
require './lib/ships'
require './lib/space'

class Game
  attr_reader :player_board, :computer_board, :ships, :player

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @ships = Ships.new
    @player = Player.new
  end

  def intro
    puts "Welcome to BATTLESHIP

    Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    initial_choice = user_input_downcase
    start_game_options(initial_choice)
  end

  def start_game_options(initial_choice)
    if initial_choice == "p" || initial_choice == "play"
      computer_place_ships
    elsif initial_choice == "i" || initial_choice == "instructions"
      instructions
    elsif initial_choice == "q" || initial_choice == "quit"
      quit
    else
      puts "Please choose either (p)lay, (i)nstructions, or (q)uit to move forward."
    end
  end

  def computer_place_ships
    @ships.computer_place_destroyer(@computer_board.grid)
    @ships.computer_place_cruiser(@computer_board.grid)
    player_ship_placement
  end

  def player_ship_placement
    puts "I have laid out my ships on the grid.
          You now need to layout your two ships.
          The first is two units long and the
          second is three units long.
          The grid has A1 at the top left and D4 at the bottom right.

          Enter the squares for the two-unit ship:"
    players_destroyer = user_input_upcase
    @player.player_place_destroyer(players_destroyer, @player_board.grid)
    puts "Now enter the squares for the three-unit ship:"
    players_crusier = user_input_upcase
    @player.player_place_cruiser(players_crusier,@player_board.grid)
    begin_game_flow
  end

  def begin_game_flow
    puts "Now we're ready to begin. Make your guess:"
    @computer_board.display_board
  end

  def quit
    puts "You have exited the game.\n Goodbye."
  end

  def instructions
    instructions = File.new(instructions.txt, 'r').read
    puts instructions
    intro
  end

  def user_input_downcase
    print ">"
    gets.chomp.downcase
  end

  def user_input_upcase
    print ">"
    gets.chomp.upcase
  end
end
