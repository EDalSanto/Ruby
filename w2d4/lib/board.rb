class Board

  attr_accessor :grid, :victor

  def initialize(grid=default_grid)
    @grid = grid
    @victor = nil
  end

  def default_grid
    Array.new(3) { Array.new(3) }
  end

  def place_mark(pos, mark)
    if empty?(pos)
      grid[pos[0]][pos[1]] = mark
    else
      puts "not empty"
    end
  end

  def empty?(pos)
    get_square(pos) == nil
  end

  def get_square(pos)
    grid[pos[0]][pos[1]]
  end

  def winner
    win_row?
    left_diagonal?
    right_diagonal?
    column?
    @victor
  end

  def win_row?
    @grid.each do |row|
      if row.all? { |el| el == :X }
        @victor = :X
      elsif row.all? { |el| el == :O }
        @victor = :O
      end
    end
  end

  def left_diagonal?
    left_diagonal = [[0, 0], [1, 1], [2, 2]]
    @victor = :X if left_diagonal.all? do |pos|

      row, col = pos[0], pos[1]
      @grid[row][col] == :X
    end

    @victor = :O if left_diagonal.all? do |pos|
      row, col = pos[0], pos[1]
      @grid[row][col] == :O
    end
  end

  def right_diagonal?
    right_diagonal = [[0, 2], [1, 1], [2, 0]]
    @victor = :X if right_diagonal.all? do |pos|
      row, column = pos[0], pos[1]
      grid[row][column] == :X
    end

    @victor = :O if right_diagonal.all? do |pos|
      row, column = pos[0], pos[1]
      grid[row][column] == :O
    end
  end

  def column?
    final_array = []
    (0..2).each do |i|
      new_array = []
      (0..2).each do |j|
        new_array << @grid[j][i]
      end
      final_array << new_array
    end

    final_array.each do |row|
      if row.all? { |el| el == :X }
        @victor = :X
      elsif row.all? { |el| el == :O }
        @victor = :O
      end
    end
  end

  def over?
    grid.flatten.none? { |space| space == nil } ? true : winner
  end


end
