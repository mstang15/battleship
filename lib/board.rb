class Board
attr_reader :grid

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
    print "A"
    puts "  #{@grid["A"][0].square_display} #{@grid["A"][1].square_display}  #{@grid["A"][2].square_display}  #{@grid["A"][3].square_display} "
    print "B"
    puts "#{@grid["B"][0].square_display} #{@grid["B"][1].square_display} #{@grid["B"][2].square_display} #{@grid["B"][3].square_display}"
    print "C"
    puts "#{@grid["C"][0].square_display} #{@grid["C"][1].square_display} #{@grid["C"][2].square_display} #{@grid["C"][3].square_display}"
    print "D"
    puts "#{@grid["D"][0].square_display} #{@grid["D"][1].square_display} #{@grid["D"][2].square_display} #{@grid["D"][3].square_display}"
    puts "==========="
  end

end
