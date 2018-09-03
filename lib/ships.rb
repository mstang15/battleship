require 'pry'
class Ships

  def initialize
    @computer_guesses = []
  end

  def computer_place_destroyer(grid)
    orientation = horizontal_or_vertical
    if orientation == "horizontal"
      horizontal_placement_destroyer(grid)
    else
      vertical_placement_destroyer(grid)
    end
  end

  def computer_place_cruiser(grid)
    orientation = horizontal_or_vertical
    if orientation == "horizontal"
      horizontal_placement_cruiser(grid)
    else
      vertical_placement_cruiser(grid)
    end
  end

  def horizontal_placement_destroyer(grid)
    keys = grid.keys
    index_random_column = ["01","12","23"]
    k = keys.sample(1).shift
    i = index_random_column.sample(1).shift
    grid[k][i[0].to_i].ship_placed
    grid[k][i[1].to_i].ship_placed
    ship_coordinates = [[k][i[0].to_i],[k][i[1].to_i]]
  end

  def vertical_placement_destroyer(grid)
    keys = ["AB","BC","CD"]
    index= [0,1,2,3]
    i = index.sample(1).shift
    k = keys.sample(1).shift
    grid[k[0]][i].ship_placed
    grid[k[1]][i].ship_placed
    ship_coordinates = [[k[0]][i],[k[1]][i]]
  end

  def horizontal_placement_cruiser(grid)
    keys = grid.keys
    index_random_columns = ["012","123"]
    k = keys.sample(1).shift
    i = index_random_columns.sample(1).shift
    if grid[k][i[0].to_i].empty && grid[k][i[1].to_i].empty && grid[k][i[2].to_i].empty
      grid[k][i[0].to_i].ship_placed
      grid[k][i[1].to_i].ship_placed
      grid[k][i[2].to_i].ship_placed
    else
      horizontal_placement_cruiser(grid)
    end
    ship_coordinates = [[k][i[0].to_i],[k][i[1].to_i],[k][i[2].to_i]]
  end

  def vertical_placement_cruiser(grid)
    keys = ["ABC","BCD"]
    index= [0,1,2,3]
    k = keys.sample(1).shift
    i = index.sample(1).shift
    if grid[k[0]][i].empty && grid[k[1]][i].empty && grid[k[2]][i].empty
      grid[k[0]][i].ship_placed
      grid[k[1]][i].ship_placed
      grid[k[2]][i].ship_placed
    else
      vertical_placement_cruiser(grid)
    end
    ship_coordinates = [[k[0]][i],[k[1]][i],[k[2]][i]]

  end

  def horizontal_or_vertical
    num = rand(0..1)
    if num == 0
      "horizontal"
    else
      "vertical"
    end
  end

  def generate_random_guess
    row = ["A","B","C","D"]
    column = [1,2,3,4]
    random_row = row.sample(1).shift
    random_column = column.sample(1).shift
    current_guess = "#{random_row}#{random_column}"
    if @computer_guesses.include?(current_guess)
    generate_random_guess
    else
    @computer_guesses << current_guess
    end
    return current_guess
  end

end
