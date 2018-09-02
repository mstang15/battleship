class Player
  def initialize
  end

  def player_place_destroyer(coordinates,grid)
    coordinate = coordinates.split
    key = coordinate.map do |coordinate|
          coordinate[0]
          end
    index = coordinate.map do |coordinate|
            coordinate[-1].to_i
            end
    grid[key[0]][index[0]].ship_placed
    grid[key[1]][index[1]].ship_placed
  end

  def player_place_cruiser(coordinates_list, grid)
    coordinates = coordinate_list.split
    key = coordinates.map do |coordinate|
          coordinate[0]
          end
    index = coordinates.map do |coordinate|
            coordinate[-1].to_i
            end
    interpret_cruiser_coordinates(key,index, grid)
  end

  def interpret_cruiser_coordinates(key_array,index_array, grid)
    if key_array[0] == key_array[1]
          last_index = index_array[-1]
          index_array.insert(1,last_index - 1)
    elsif index_array[0] == index_array[1] && key_array[0] == "A"
          key_array.insert(1,"B")
    elsif index_array[0] == index_array[1] && key_array[0] == "B"
          key_array.insert(1,"C")
    end

    grid[key_array[0]][index_array[0]].ship_placed
    grid[key_array[1]][index_array[1]].ship_placed
    grid[key_array[2]][index_array[2]].ship_placed
  end

end
