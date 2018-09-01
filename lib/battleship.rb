
class Battleship

  def initialize
  end

  def intro
    print "Welcome to BATTLESHIP

    Would you like to (p)lay, read the (i)nstructions, or (q)uit?
    >"
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
    gets.downcase
  end
end
