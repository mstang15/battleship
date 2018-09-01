class Board

  def initialize
    @grid = empty_playing_grid
  end

  def empty_playing_grid
    {"A" => [Space.new, Space.new, Space.new, Space.new],
    "B" => [Space.new, Space.new, Space.new, Space.new],
    "C" => [Space.new, Space.new, Space.new, Space.new],
    "D" => [Space.new, Space.new, Space.new, Space.new]}
  end

  def display_board
    puts "==========="
    puts ". 1 2 3 4"
    puts "A #{@grid["A"]}\n B #{@grid["B"]}\n C #{@grid["C"]}\n D #{@grid["C"]}"
    puts "==========="
  end

end
