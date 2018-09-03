class Validate
  def initialize
    @player_guesses = []
    @computer_guesses = []
  end

  def store_player_guesses(user_guess,grid)
    @player_guesses << user_guess
    hit_guess(user_guess,grid)
  end

  def store_computer_guesses(computer_guess,grid)
    @computer_guesses << computer_guess
    hit_guess(computer_guess,grid)
  end

  def hit_guess(user_guess,grid)
    row = user_guess[0]
    column = user_guess[-1].to_i
    grid[row][column-1].guess
  end

  def hit_or_miss(user_input_upcase,grid)
    key = user_input_upcase[0]
    index = user_input_upcase[-1].to_i
    space = grid[key][index-1]
    if !space.ship_present
      return "MISSED"
    else
      return "HIT"
    end
  end

  def validate_destroyer_placement(user_input)
    array = ["A","B","C","D"]
    two_coordinates = user_input.split
    first= two_coordinates[0]
    second = two_coordinates[1]
    if (first[-1].to_i > 4) || (second[-1].to_i >4)
      puts "The board only has 4 columns. Please use longitude coordinates no greater than 4."
      return false
    elsif two_coordinates.length != 2
      puts "You need to enter exactly two coordinates for the destroyer to be placed."
      return false
    elsif ((first[0] == second[0]) && ((second[-1].to_i - first[-1].to_i) != 1))
      puts "Please make sure the coordinates you entered are right next to each other."
      return false
    elsif (array.index(second[0]) - array.index(first[0])) > 1
      puts "Please make sure the coordinates you enter are right next to each other"
      return false
    else
      puts "Excellent, those coordinates have been recorded."
      true
    end
  end



end
