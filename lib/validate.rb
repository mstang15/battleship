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
      print "You guessed #{user_input_upcase} and you MISSED!"
    else
      print "You guessed #{user_input_upcase} and you HIT my ship!"
    end
  end
end
