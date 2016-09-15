require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

class Game
  attr_accessor :mark, :board, :current_player

  def initialize(player_one,player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board.new
    @current_player = player_one
  end

  def switch_players!
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

  def play_turn
    move = current_player.get_move
    @board.place_mark(move,current_player.mark)
    switch_players!
  end

  def play
    puts "Welcome to a game of Tic-Tac_Toe!"
    while !@board.over?
      play_turn
      @board.display
      puts "++++++++++++++++"
    end
    puts "Final Board"
    @board.display
  end
end

if __FILE__ == $PROGRAM_NAME
  human_player = HumanPlayer.new("Buckalis")
  human_player.mark = :X
  computer_player = ComputerPlayer.new("Bozzo")
  computer_player.mark = :O
  game = Game.new(human_player, computer_player)
  computer_player.display(game.board)
  game.play
end
