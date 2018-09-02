class Validate
  def initialize
    @player_guesses = []
  end

  def store_guesses(user_guess,grid)
    @player_guesses << user_guess
    hit_guess(user_guess,grid)
  end


  def hit_guess(user_guess,grid)
    row = user_guess[0]
    column = user_guess[-1].to_i
    grid[row][column-1].guess
  end
end
