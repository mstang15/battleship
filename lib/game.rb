require './lib/board'
require './lib/player'
require './lib/ships'
require './lib/space'
require './lib/validate'
require 'pry'

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
    puts "Welcome to BATTLESHIP\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
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
      puts "I have laid out my ships on the grid.\nYou now need to layout your two ships.\nThe first is two units long and the\nsecond is three units long.\nThe grid has A1 at the top left \nand D4 at the bottom right.\n\nEnter the squares for the two-unit ship:"
    validate_response = false
    while validate_response != true
      players_destroyer = user_input_upcase
      validate_response = @validate.validate_destroyer_placement(players_destroyer)
    end
    @player.player_place_destroyer(players_destroyer, @player_board.grid)
    puts "Now enter the squares for the three-unit ship:"
    players_crusier = user_input_upcase
    @player.player_place_cruiser(players_crusier,@player_board.grid)
    begin_game_flow
  end

  def begin_game_flow
    puts "Now we're ready to begin."
    @computer_board.display_board
    puts "Pictured above is my hidden board. Where do you wish to fire first?"
    player_shot_sequence
  end

  def player_shot_sequence
    player_guess = user_input_upcase
    @validate.store_player_guesses(player_guess,@computer_board.grid)
    @computer_board.display_board
    hit_or_miss = @validate.hit_or_miss(player_guess,@computer_board.grid)
    puts "You guessed #{player_guess} and #{hit_or_miss} my ship!\nPress the enter key so that I can take my turn."
    print ">"
    enter = gets
    while enter != "\n"
      puts " Please press enter so I can have my turn."
      enter = gets
    end
    computer_shot_sequence
  end

  def computer_shot_sequence
    current_guess = @ships.generate_random_guess
    @validate.store_computer_guesses(current_guess,@player_board.grid)
    hit_or_miss = @validate.hit_or_miss(current_guess,@player_board.grid)
    puts "\nMy Guesses"
    @player_board.display_board
    puts "\nYour Guesses"
    @computer_board.display_board
    puts "I guessed #{current_guess} and #{hit_or_miss} your ship!\nYou can see both of our boards above."
    puts "It's your turn again. What coordinate do you wish to fire at?"
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
