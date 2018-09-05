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
    @count_turns = 0
    @start_time = 0
  end

  def intro
    puts `clear`
    puts "\n\nWelcome to BATTLESHIP\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
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
    player_ship_placement_instructions_1
    players_destroyer = get_player_destroyer
    @player.player_place_destroyer(players_destroyer, @player_board.grid)
    puts "\n\nNow enter the squares for the three-unit ship:"
    players_cruiser = get_player_cruiser
    cruiser = @player.player_place_cruiser(players_cruiser,@player_board.grid)
    @validate.store_player_ships(players_destroyer,cruiser)
    user_input_enter
    puts `clear`
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
    players_cruiser.split
  end

  def begin_game_flow
    @start_time = Time.now
    puts "Now we're ready to begin."
    @computer_board.display_board
    puts "Pictured above is my hidden board. Where do you wish to fire first?"
    player_shot_sequence
  end

  def player_shot_sequence
    @count_turns += 1
    guess = retrieve_player_guess
    puts `clear`
    @validate.store_player_guesses(guess,@computer_board.grid)
    display_both_boards
    hit_or_miss = @validate.hit_or_miss(guess,@computer_board.grid)
    won = check_if_someone_won(@computer_board.grid)
    if won == true
      player_wins
    end
    puts "You guessed #{guess} and #{hit_or_miss} my ship!\nPress the enter key so that I can take my turn."
    user_input_enter
    computer_shot_sequence
  end

  def retrieve_player_guess
    player_guess = false
    while player_guess != true
        guess = user_input_upcase
      if guess.downcase == "quit"
        quit
        return true
      else
        player_guess = @validate.validate_guess(guess)
      end
    end
    return guess
  end

  def computer_shot_sequence
    guess = @ships.generate_random_guess
    puts `clear`
    @validate.store_computer_guesses(guess,@player_board.grid)
    hit_or_miss = @validate.hit_or_miss(guess,@player_board.grid)
    computer_shot_sequence_output(guess,hit_or_miss)
    player_shot_sequence
  end

  def computer_shot_sequence_output(guess,hit_or_miss)
    display_both_boards
    puts "I guessed #{guess} and #{hit_or_miss} your ship!"
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

  def display_both_boards
    puts "\nMy Guesses"
    @player_board.display_board
    puts "\nYour Guesses"
    @computer_board.display_board
  end

  def instructions
    puts `clear`
    instructions = File.new('./lib/instructions.txt', 'r').read
    puts instructions
    puts "Press enter to go back to welcome screen."
    user_input_enter
    puts `clear`
    intro
  end

  def calculate_time_difference
    total_time = (Time.now - @start_time).round
    seconds = total_time % 60
    minutes = (total_time/ 60) % 60
    [minutes,seconds]
  end

  def player_ship_placement_instructions_1
    puts "\n\nI have laid out my ships on the grid.\nYou now need to layout your two ships.\nThe first is two units long and the\nsecond is three units long.\nThe grid has A1 at the top left \nand D4 at the bottom right.\n\nEnter the squares for the two-unit ship:"
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
      puts "Please press enter."
      enter = gets
    end
  end

  def player_wins
    puts "\n\nCONGRATULATIONS! You won this round of battleship.\nThis game took us #{calculate_time_difference[0]} minutes and #{calculate_time_difference[1]} seconds to play, and you won in #{@count_turns} turns!\n\n"
    quit
  end

  def computer_wins
    puts "\n\nI WIN! Better luck next time!\nThis game took us #{calculate_time_difference[0]} minutes and #{calculate_time_difference[1]} seconds to play, and I won in #{@count_turns} turns!\n\n"
    quit
  end

  def quit
    puts "Thanks for playing.\nGoodbye.\n\n"
    exit!
  end

end
