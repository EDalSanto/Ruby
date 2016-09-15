require 'byebug'

class Board
  attr_accessor :grid

  def initialize(grid=Board.default_grid)
    @grid = grid
  end

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def count
    ships = 0
    @grid.each do |row|
      ships += row.count(:s)
    end
    ships
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def no_ships?
    @grid.each do |row|
      row.each do |cell|
        return false if cell != nil
      end
    end
    return true
  end

  def empty?(pos=[0,0])
    # No ships on board or passed position
    # byebug
    row = pos[0]
    col = pos[1]
    return true if (no_ships?) || (@grid[row][col] == nil)
    # Not passed a position and ships on board
    return false if !no_ships?
  end

  def full?
    @grid.each do |row|
      row.each do |cell|
        return false if cell != :s
      end
    end
    return true
  end

  def place_random_ship
    raise "Board is full!" if full?
    rand_row = rand(@grid.length)
    rand_col = rand(@grid.length)
    @grid[rand_row][rand_col] = :s
  end

  def won?
    @grid.each do |row|
      row.each do |cell|
        return false if cell != nil
      end
    end
    return true
  end

  def display
    @grid.each_with_index do |row|
      print "|"
      row.each do |cell|
        print "  #{cell} |" if cell == nil
        print " #{cell} |" if cell != nil
      end
      puts "\n" + ("-----" * (@grid.length-2)) + "-"
    end
  end

  def in_range?(pos)
    begin
      pos.all? { |x| x.between?(0, grid.length - 1) }
    rescue
      puts "Position not in range"
    end
  end

  def populate_grid
    ships = rand(100)
    ships.times do |ship|
      begin
        place_random_ship
      rescue
        retry
      end
    end
  end
end
