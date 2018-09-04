class Player
  def initialize
  end

  def player_place_destroyer(players_destroyer,grid)
    coordinate_array = players_destroyer.split
    key = coordinate_array.map do |coordinate|
          coordinate[0]
          end
    index = coordinate_array.map do |coordinate|
            coordinate[-1].to_i
            end
    assign_coordinates_to_ship(key,index,grid)
    return player_ship_array(key,index)
  end

  def player_place_cruiser(players_cruiser, grid)
    coordinate_array = players_cruiser.split
    key = coordinate_array.map do |coordinate|
          coordinate[0]
          end
    index = coordinate_array.map do |coordinate|
            coordinate[-1].to_i
            end
    interpret_cruiser_coordinates(key, index, grid)
  end

  def interpret_cruiser_coordinates(key_array,index_array, grid)
    if key_array[0] == key_array[1]
          interpret_if_same_letter(key_array,index_array,grid)
    elsif index_array[0] == index_array[1]
          interpret_if_same_index(key_array,index_array,grid)
    end
  end

  def interpret_if_same_letter(key_array,index_array,grid)
      mid_index = index_array.min + 1
      new_index = index_array.insert(1,mid_index)
      new_keys = key_array.insert(1,key_array[0])
      assign_coordinates_to_ship(new_keys,new_index,grid)
      return player_ship_array(new_keys,new_index)
  end

  def assign_coordinates_to_ship(new_keys,new_index,grid)
    i = 0
    new_keys.each do |row|
      grid[row][new_index[i]-1].ship_placed
      i+=1
    end
  end

  def interpret_if_same_index(key_array,index_array,grid)
    mid_key = key_array.min.next
    new_key = key_array.insert(1,mid_key)
    new_index = index_array.insert(1,index_array[0])
    assign_coordinates_to_ship(new_key,new_index,grid)
    return player_ship_array(new_key,new_index)
  end

  def player_ship_array(new_keys,new_index)
    i = -1
    new_keys.map do |letter|
      i += 1
      string = letter + new_index[i].to_s
    end
  end

end
