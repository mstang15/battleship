require './lib/board'
require './lib/player'
require './lib/ships'
require './lib/space'
require './lib/validate'

class Game
  attr_reader :player_board, :computer_board, :ships, :player

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @ships = Ships.new
    @player = Player.new
    @validate = Validate.new
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
    puts "Now we're ready to begin."
    @computer_board.display_board
    puts "Pictured above is the game board. Where do you wish to fire first?"
    player_shot_sequence
  end

  def player_shot_sequence
    @validate.store_guesses(user_input_upcase,@computer_board.grid)
    @computer_board.display_board
    puts "See above to know if you hit or missed.Now it's the computers turn."
    computer_shot_sequence
  end

  def computer_shot_sequence
    current_guess = @ships.generate_random_guess
    @validate.hit_guess(current_guess,@player_board.grid)
    puts "The computer guessed #{current_guess}.\n You can see both of your boards below."
    @computer_board.display_board
    @player_board.display_board
    puts "Your turn. What coordinate do you wish to fire at?"
    player_shot_sequence
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
