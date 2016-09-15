class HumanPlayer

  def initialize(name="John")
    @valid_rows = ('A'..'J').to_a
    @valid_cols = (1..10).to_a
    @name = name
  end

  def get_play
    puts "Please enter valid location on board"
    row,col = gets.chomp.split('')
    row = row.upcase
    col = col.to_i
    pos = translate(row,col)
  end

  def translate(row,col)
    x = @valid_rows.index(row)
    y = @valid_cols.index(col.to_i)
    [x,y]
  end

end
