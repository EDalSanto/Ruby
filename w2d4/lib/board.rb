class Board
  attr_accessor :players, :victor
  attr_reader :winner,:grid

  def initialize(grid=default_grid)
    # Create grid on board
    @grid = grid
    @victor = nil
  end

  def default_grid
    Array.new(3) { Array.new(3) }
  end

  def get_cell(pos)
    @grid[pos[0]][pos[1]]
  end

  def place_mark(pos,mark)
    if empty?(pos)
      @grid[pos[0]][pos[1]] = mark
    else
      puts "Cell not empty!"
    end
  end

  def empty?(pos)
    get_cell(pos) == nil
  end

  def diagonals
    [
      [get_cell([0, 0]), get_cell([1, 1]), get_cell([2, 2])],
      [get_cell([0, 2]), get_cell([1, 1]), get_cell([2, 0])]
    ]
  end

  def winner
    win_row?
    win_col?
    win_diag?
    @victor
  end

  def win_row?
    @grid.each do |row|
      if row.all? { |cell| cell == :X }
        @victor = :X
      elsif row.all? { |cell| cell == :O }
        @victor = :O
      end
    end
  end

  def win_col?
    @grid.transpose.each do |col| # transpose method flips rows into columns that is arrays are now grouped as columns
      if col.all? { |cell| cell == :X }
        @victor = :X
      elsif col.all? { |cell| cell == :O }
        @victor = :O
      end
    end
  end

  def win_diag?
    diagonals.each do |row|
      if row.all? { |cell| cell == :X }
        @victor = :X
      elsif row.all? { |cell| cell == :O }
        @victor = :O
      end
    end
  end

  def tied?
    no_nil_cells = 0
    @grid.each do |row|
      no_nil_cells += 1 if !row.all?(&:nil?)
    end
    no_nil_cells == 3
  end

  def over?
    (winner != nil) || tied?
  end

  def display
    @grid.each do |row|
      print "|"
      row.each { |cell| print "  #{cell}  |" }
      puts "\n-----------------"
    end
  end


end
