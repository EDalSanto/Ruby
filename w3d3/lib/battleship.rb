require_relative 'board'
require_relative 'player'

class BattleshipGame
  attr_reader :board, :player

  def initialize(player=HumanPlayer.new,board=Board.new)
    @player = player
    @board = board
    @hit
  end

  def attack(pos)
    if @board[pos] == :s || @board[pos] == nil
      @board[pos] = :x
      @hit = true
    else
      @hit = false
    end
  end

  def count
    @board.count
  end

  def hit?
    @hit
  end

  def game_over?
    @board.won?
  end

  def valid_play?(pos)
    @board.in_range?(pos)
  end

  def play_turn
    pos = @player.get_play
    if @board.in_range?(pos)
      attack(pos)
    else
      pos = play_turn
    end
  end

  def play
    @board.populate_grid
    while !game_over?
      @board.display
      puts "Number of ships remaining: #{@board.count}"
      play_turn
      if @hit
        puts "You sunk my battleship!"
      else
        puts "No ship at that location"
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  game = BattleshipGame.new
  game.play
end
