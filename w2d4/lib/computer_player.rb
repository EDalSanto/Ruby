class ComputerPlayer
  attr_accessor :board, :mark

  def initialize(name)
    @name = name
  end

  def display(board)
    @board = board
  end

  def random_move
    random_row = rand(2)
    random_col = rand(2)
    [random_row,random_col]
  end

  def winning_move?
    @board.grid.each_with_index do |row,row_idx|
      row.each_index do |col_idx|
        pos = [row_idx,col_idx]
        next if !@board.empty? pos
        @board.place_mark(pos, @mark)
        if @board.winner
          return pos
        else # Reset mark place
          nilify_cell(pos)
        end
      end
    end
    false
  end

  def nilify_cell(pos)
    @board.grid[pos[0]][pos[1]] = nil
  end

  def get_move
    winning_move = winning_move?
    winning_move ? winning_move : random_move
  end

end
