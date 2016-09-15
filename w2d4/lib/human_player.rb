class HumanPlayer
  attr_accessor :name, :mark

  def initialize(name)
    @name = name
  end

  def display(board)
    board.grid.each do |row|
      print "|"
      row.each { |cell| print "  #{cell}  |" }
      puts "\n-------------------"
    end
  end

  def get_move
    puts "Where would you like to place a mark?"
    puts "Enter row between 0 and 2 and column between 0 and 2"
    input = gets.chomp
    row = input.scan(/\d/)[0].to_i
    column = input.scan(/\d/)[1].to_i
    valid_inputs = [0,1,2]
    if (!valid_inputs.include? row) || (!valid_inputs.include? column)
      puts "Invalid input! Try again!"
      row,column = get_move
    end
    [row,column]
  end

end
