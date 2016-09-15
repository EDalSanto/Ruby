require 'byebug'

class Hangman
  MAX_GUESSES = 6

  attr_reader :guesser, :referee, :board

  def initialize(players)
    @players = players
    @guesser = players[:guesser]
    @referee = players[:referee]
    @guesses_left = MAX_GUESSES
    @already_guessed = []
    @match = false
  end

  def setup
    length = @referee.pick_secret_word
    @referee.register_secret_length(length)
    @board = "-" * length
  end

  def correct_guess?(matched_indices)
    if matched_indices.empty?
      @match = false
      puts "Sorry, no match"
    else
      @match = true
      if matched_indices.length > 1
        puts "Match! You had #{matched_indices.length} matches"
      else
        puts "Match! You had 1 match"
      end
    end
  end

  def guess_word?
    # Ala Wheel of Fortune
    puts "Enter 'yes' if you'd like guess the word"
    choice = gets.chomp
    if choice == "yes"
      puts "Alright, guess away!"
      guess = gets.chomp
      if guess == @referee.secret_word
        puts "You guessed correctly!"
      else
        puts "Sorry, incorrect guess"
      end
    else
      puts "Ok, no guess"
    end
    puts "\n"
  end

  def take_turn
    puts "Letters guessed so far: #{@already_guessed}"
    guess = @guesser.guess(board)
    @already_guessed << guess
    @guesses_left -= 1
    indices = @referee.check_guess(guess)
    correct_guess?(indices)
    update_board(guess,indices)
    display_board
    @referee.handle_response(guess,indices)
  end

  def play
    while @guesses_left > 0
      puts "=======Guesses left->#{@guesses_left}=======\n"
      take_turn
      return "Winner, Winner, Chicken Dinner!" if won? || guess_word?
    end
    puts "You ran out of guesses, sorry"
  end

  def display_board
    p @board
  end

  def update_board(guess,indices)
    indices.each { |index| @board[index] = guess }
  end

  def won?
    @referee.secret_word == @board
  end

end

class HumanPlayer
  attr_reader :guess

  def initialize(name="Johnbob")
    @name = name
  end

  def guess(board)
    p board
    puts "Please guess a letter!"
    guess = gets.chomp
  end

  def register_secret_length(secret_length)
    puts "Secret word is #{secret_length} letters long"
  end

  def pick_secret_word
    puts 'Please think of a secret word. How long is it?'
    begin
      length = gets.chomp.to_i
    rescue ArgumentError
      puts "Please enter a valid length!"
      retry
    end
  end

  def handle_response(guess, response)
    puts "Found #{guess} at positions #{response}"
  end

end

class ComputerPlayer
  def self.player_with_dict_file(dict_file)
    ComputerPlayer.new(File.readlines(dict_file).map(&:chomp))
  end

  attr_accessor :candidate_words

  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = nil
    @candidate_words = dictionary
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word.length
  end

  def check_guess(guess)
    indices = []
    secret_word.chars.each_with_index do |char,index|
      indices << index if char == guess
    end
    indices
  end

  def register_secret_length(secret_length)
    length = secret_length
    @candidate_words = @candidate_words.select { |word| word.length == length }
    length
  end

  def guess(board)
    # contain_known_letters?
    hist_candidate_words(board).max_by { |k,v| v }.first
  end

  def contain_known_letters?(known)
    @candidate_words.select do |word|
      if word.chars.all? { |char| known.include? char }
      end
    end
  end

  def hist_candidate_words(board)
    letters_count = Hash.new(0)
    @candidate_words.each do |word|
      # Only checking empty spots on board
      board.each_with_index do |letter,index|
        if letter.nil?
          candidate_letter = word[index]
          letters_count[candidate_letter] += 1
        end
      end
    end
    letters_count
  end

  def handle_response(guess,indices)
    @candidate_words.each do |word|
      # Matching indexes in word for guess?
      indices.each do |index|
        if word[index] != guess
          @candidate_words.delete(word)
        end
      end
      # Matching # of occurences of guess in word?
      @candidate_words.delete(word) if word.count(guess) > indices.length
    end
  end

  def secret_word
    @secret_word
  end

end

if __FILE__ == $PROGRAM_NAME
  robo = ComputerPlayer.player_with_dict_file("lib/dictionary.txt")
  human = HumanPlayer.new
  players = { referee: robo, guesser: human }
  game = Hangman.new(players)
  game.setup
  game.play
end
