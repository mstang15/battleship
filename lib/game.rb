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
      if_choice_is_not_an_option
    end
  end

  def if_choice_is_not_an_option
    puts "Please choose either (p)lay, (i)nstructions, or (q)uit to move forward."
    new_response = user_input_downcase
    start_game_options(new_response)
  end

  def computer_place_ships
    destroyer =  @ships.computer_place_destroyer(@computer_board.grid)
    cruiser = @ships.computer_place_cruiser(@computer_board.grid)
    store_computer_ships = @validate.store_computer_ships(destroyer,cruiser)
    player_ship_placement
  end

  def player_ship_placement
    puts "I have laid out my ships on the grid.\nYou now need to layout your two ships.\nThe first is two units long and the\nsecond is three units long.\nThe grid has A1 at the top left \nand D4 at the bottom right.\n\nEnter the squares for the two-unit ship:"
    players_destroyer = get_player_destroyer
    place_players_destroyer(players_destroyer)
    puts "Now enter the squares for the three-unit ship:"
    players_cruiser = get_player_cruiser
    cruiser = place_players_cruiser(players_cruiser)
    store_player_ships(players_destroyer, cruiser)
    begin_game_flow
  end

  def get_player_destroyer
    validate_response = false
    while validate_response != true
      players_destroyer = user_input_upcase
      validate_response = @validate.validate_destroyer_placement(players_destroyer)
    end
    players_destroyer.split
  end

  def get_player_cruiser
    validate_cruiser = false
    while validate_cruiser!= true
    players_cruiser = user_input_upcase
    validate_cruiser = @validate.validate_cruiser_placement(players_cruiser,@player_board.grid)
    end
    players_cruiser
  end

  def place_players_destroyer(players_destroyer)
    @player.player_place_destroyer(players_destroyer, @player_board.grid)
  end

  def place_players_cruiser(players_cruiser)
    @player.player_place_cruiser(players_cruiser.split,@player_board.grid)
  end

  def store_player_ships(players_destroyer,players_cruiser)
    @validate.store_player_ships(players_destroyer,players_cruiser)
  end

  def begin_game_flow
    puts "Now we're ready to begin."
    @computer_board.display_board
    puts "Pictured above is my hidden board. Where do you wish to fire first?"
    player_shot_sequence
  end

  def player_shot_sequence
    guess = retrieve_player_guess
    store_player_guess(guess)
    @computer_board.display_board
    hit_or_miss = @validate.hit_or_miss(guess,@computer_board.grid)
    won = check_if_someone_won(@computer_board.grid)
    if won == true
      player_wins
    end
    puts "You guessed #{guess} and #{hit_or_miss} my ship!\nPress the enter key so that I can take my turn."
    user_input_enter
    computer_shot_sequence
  end

  def player_wins
    puts "CONGRATULATIONS! You won this round of battleship."
    quit
  end

  def computer_wins
    puts "I WIN! Better luck next time!"
    quit
  end

  def retrieve_player_guess
    player_guess = false
    while player_guess != true
        guess = user_input_upcase
      if guess.downcase == "quit"
        quit
        return true
      else
        player_guess = validate_player_guess(guess)
      end
    end
    return guess
  end

  def validate_player_guess(guess)
    @validate.validate_guess(guess)
  end

  def store_player_guess(guess)
    @validate.store_player_guesses(guess,@computer_board.grid)
  end

  def computer_shot_sequence
    guess = retrieve_computer_guess
    store_computer_guess(guess)
    hit_or_miss = record_hit_or_miss(guess)
    computer_shot_sequence_output(guess,hit_or_miss)
    player_shot_sequence
  end

  def retrieve_computer_guess
    @ships.generate_random_guess
  end

  def store_computer_guess(guess)
    @validate.store_computer_guesses(guess,@player_board.grid)
  end

  def record_hit_or_miss(guess)
    @validate.hit_or_miss(guess,@player_board.grid)
  end

  def computer_shot_sequence_output(guess,hit_or_miss)
    puts "\nMy Guesses"
    @player_board.display_board
    puts "\nYour Guesses"
    @computer_board.display_board
    puts "I guessed #{guess} and #{hit_or_miss} your ship!\nYou can see both of our boards above."
    won = check_if_someone_won(@player_board.grid)
    if won == true
      computer_wins
    end
    puts "It's your turn again. What coordinate do you wish to fire at?"
  end

  def check_if_someone_won(grid)
    num_sunk_ships = grid.values.flatten.find_all do |space|
                  space.sunk == true
                  end
    if num_sunk_ships.length == 5
      true
    end
  end

  def quit
    puts "Thanks for playing.\nGoodbye."
    exit!
  end

  def instructions
    instructions = File.new('./lib/instructions.txt', 'r').read
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

  def user_input_enter
    print ">"
    enter = gets
    while enter != "\n"
      puts " Please press enter so I can have my turn."
      enter = gets
    end
  end
end
