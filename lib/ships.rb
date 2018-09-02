class Ships

  def initialize
  end

  def computer_place_destroyer(grid)
    first_coordinate= initial_random_placement(grid)
    second_coordinate= random_vertical_or_horizontal(first_coordinate)
  end

  def computer_place_cruiser(grid)
    initial_random_placement(grid)
  end

  def initial_random_placement(grid)
    random_row = grid.keys.sample(1).shift.strip
    random_column = rand(0..3)
    random_initial_placement = [random_row,random_column]
    if grid[random_row][random_column].empty
      random_initial_placement
    else
      initial_random_placement(grid)
    end
  end

  def horizontal_placement(first_coordinate)
    if first_coordinate[1] == 0
      second_coordinate = 1
    elsif first_coordinate[1] == 1
      second_coordinate = 2
    elsif first_coordinate[1] == 2
      second_coordinate = 3
    elsif first_coordinate[1] == 3
      second_coordinate = 2
    end
    [first_coordinate[0],second_coordinate]
  end

  def vertical_placement(first_coordinate)
    if first_coordinate[0] == "A"
      second_coordinate = "B"
    elsif first_coordinate[0] == "B"
      second_coordinate = "C"
    elsif first_coordinate[0] == "C"
      second_coordinate = "D"
    elsif first_coordinate[0] == "D"
      second_coordinate = "C"
    end
    [second_coordinate,first_coordinate[1]]
  end

  def random_vertical_or_horizontal(first_coordinate)
    random = rand(0..1)
    if random == 0
      horizontal_placement(space_string)
    else
      vertical_placement(space_string)
    end
  end
end
