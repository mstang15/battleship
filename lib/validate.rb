class Validate
  def initialize
    @player_guesses = []
    @computer_guesses = []
    @computer_destroyer = []
    @computer_cruiser = []
    @player_destroyer = []
    @player_cruiser = []
  end

  def store_player_guesses(user_guess,grid)
    @player_guesses << user_guess
    check_if_sunk(@player_guesses, @computer_destroyer, @computer_cruiser,grid)
    hit_guess(user_guess,grid)
  end

  def store_computer_guesses(computer_guess,grid)
    @computer_guesses << computer_guess
    check_if_sunk(@computer_guesses, @player_destroyer, @player_cruiser, grid)
    hit_guess(computer_guess,grid)

  end

  def hit_guess(user_guess,grid)
    row = user_guess[0]
    column = user_guess[-1].to_i
    grid[row][column-1].guess
  end

  def check_if_sunk(guesses, destroyer_placement, cruiser_placement,grid)
    if (destroyer_placement.flatten- guesses).empty?
        sunk(destroyer_placement,grid)
    end
    if (cruiser_placement.flatten - guesses).empty?
        sunk(cruiser_placement,grid)
    end
    # if (destroyer_placement.flatten- guesses).empty? && (cruiser_placement.flatten - guesses).empty?
    #   decide_who_won(guesses)
    # end
  end

  # def decide_who_won(guesses)
  #   if @computer_guesses == guesses
  #     return true
  #   elsif @player_guesses == guesses
  #     return false
  #   end
  # end

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

  def store_computer_ships(computer_destroyer,computer_cruiser)
    destroyer = computer_destroyer.map do |coordinate|
      coordinate[0] + (coordinate[-1].to_i + 1).to_s
    end
    cruiser = computer_cruiser.map do |coordinate|
      coordinate[0] + (coordinate[-1].to_i+1).to_s
    end
    @computer_destroyer << destroyer.shift(2)
    @computer_cruiser << cruiser.shift(3)
  end

  def store_player_ships(player_destroyer,player_cruiser)
    destroyer_to_array = player_destroyer.split(" ")
    @player_destroyer << destroyer_to_array.shift(2)
    @player_cruiser << player_cruiser.shift(3)

  end


  def sunk(ship,grid)
    flat = ship.flatten
    if flat.length == 2
      grid[flat[0][0]][flat[0][-1].to_i-1].sunk
      grid[flat[1][0]][flat[1][-1].to_i-1].sunk
      puts "The Destroyer has been sunk!"
    elsif flat.length == 3
      grid[flat[0][0]][flat[0][-1].to_i-1].sunk
      grid[flat[1][0]][flat[1][-1].to_i-1].sunk
      grid[flat[2][0]][flat[2][-1].to_i-1].sunk
      puts  "The Cruiser has been sunk!"
    end
  end

  def validate_guess(user_guess)
    rows = ["A","B","C","D"]
    if user_guess.length != 2
      puts "You only need to enter a row and column... just two characters."
      return false
    elsif user_guess[-1].to_i > 4 || user_guess[-1].to_i == 0
      puts "The board only has 4 columns. Please use longitutde coordinates no greater than 4."
      return false
    elsif !rows.include?(user_guess[0])
      puts "That is not a row on the board. Please try entering that coordinate again."
      return false
    else
      return true
    end
  end

  def validate_destroyer_placement(user_input)
    rows = ["A","B","C","D"]
    two_coordinates = user_input.split
    first= two_coordinates[0]
    second = two_coordinates[1]
    if two_coordinates.length != 2
      puts "You need to enter exactly two coordinates for the destroyer to be placed."
      return false
    elsif (first[-1].to_i > 4) || (second[-1].to_i >4)
      puts "The board only has 4 columns. Please use longitude coordinates no greater than 4."
      return false
    elsif ((first[0] == second[0]) && ((second[-1].to_i - first[-1].to_i).abs != 1))
      puts "Please make sure the coordinates you entered are right next to each other."
      return false
    elsif (rows.index(second[0]) - rows.index(first[0])).abs > 1
      puts "Please make sure the coordinates you enter are right next to each other"
      return false
    else
      puts "Excellent, those coordinates have been recorded."
      true
    end
  end

  def validate_cruiser_placement(user_input,grid)
    rows = ["A","B","C","D"]
    two_coordinates = user_input.split
    first = two_coordinates[0]
    second = two_coordinates[1]
    if two_coordinates.count != 2
      puts "Please enter exactly two coordinates such that you have the beginning coordinate of your cruiser, and the ending coordinate of your cruiser."
      return false
    elsif (first[-1].to_i > 4) || (second[-1].to_i >4)
      puts "The board only has 4 columns. Please use longitude coordinates no greater than 4."
      return false
    elsif ((first[0] == second[0]) && ((second[-1].to_i - first[-1].to_i).abs != 2))
      puts "These coordinates create a ship that isn't 3 squares long. Enter your coordinates so that you can place your cruiser across three squares."
      return false
    elsif (rows.index(second[0]) - rows.index(first[0])).abs > 2 || (rows.index(second[0]) - rows.index(first[0])).abs == 1
      puts "These coordinates create a ship that isn't 3 square long. Enter your coordinates so that you can place your cruiser across three squares on your board."
      return false
    elsif !grid[first[0]][first[-1].to_i].empty || !grid[second[0]][second[-1].to_i].empty
      puts "You have already filled one of these spots with your Destroyer. Please select different coordinates for your Cruiser."
      return false
    else
      puts "Excellent, those coordinates have been recorded."
      true
    end

  end


end
