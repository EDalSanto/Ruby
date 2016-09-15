require 'byebug'

class Code
  attr_reader :pegs

  PEGS = {
    "R"=>"Red","G"=>"Green","B"=>"Blue","Y"=>"Yellow","O"=>"Orange","P"=>"Purple"
  }


  def initialize(pegs)
    @pegs = pegs
  end

  def self.display_colors
    p "Here are your options: ", PEGS
  end

  def self.parse(colors)
    # byebug
    colors_array = colors.chars
    if colors.length == 4 && colors_array.all? { |color| color.upcase.match(/[RGBYOP]/) }
      Code.new(colors.chars)
    else
      raise "Invalid input! Try again!"
    end
  end

  def self.random
    random_pegs = []
    4.times do
      random_color = PEGS.keys.sample
      random_pegs << random_color
    end
    Code.new(random_pegs)
  end

  def [](index)
    @pegs[index]
  end

  def exact_match?(guess_code,idx)
    (self[idx]).casecmp(guess_code[idx]) == 0
  end

  def upcase_pegs
    @pegs.map { |peg| peg.upcase }
  end

  def exact_matches(guess_code)
    # byebug
    correct_colors = 0
    guess_code.pegs.each_index do |idx|
      if exact_match?(guess_code,idx)
        correct_colors += 1
      end
    end
    correct_colors
  end

  def near_matches(guess_code)
    # byebug
    nears = []
    near_correct = 0
    other_pegs = guess_code.pegs.map! { |peg| peg.upcase }
    other_pegs.each_with_index do |other_peg,idx|
      if (upcase_pegs.include? other_peg) && (!exact_match?(guess_code,idx)) && (!nears.include? other_peg)
        near_correct += 1
        nears << other_peg
      end
    end
    near_correct
  end

  def same_type?(other_obj)
    other_obj.is_a? Code
  end

  def matching_code?(other_obj)
    if same_type?(other_obj)
      code_str = self.pegs.join
      other_str = other_obj.pegs.join
      matching_test = code_str.casecmp(other_str) == 0
      matching_test
    else
      false
    end
  end

  def ==(other_obj)
    matching_code?(other_obj)
  end

end

class Game
  attr_reader :secret_code

  def initialize(code=nil)
    @secret_code = code || Code.random
    @current_guess = nil
    @turns = 0
  end

  def get_guess
    puts "Please enter a code guess of four colors, i.e., rrrr for \'Red,Red,Red,Red\'!"
    # byebug
    input = gets.chomp
    begin
      guess_code = Code.parse(input)
      @current_guess = guess_code
    rescue
      puts "Invalid Input. Please try again!"
      get_guess
    end
  end

  def display_matches(guess_code)
    # byebug
    exact = @secret_code.exact_matches(guess_code)
    near = @secret_code.near_matches(guess_code)
    puts "near matches: #{near}"
    puts "exact matches: #{exact}"
  end

  def won?
    secret_code = @secret_code.pegs.join
    guess = @current_guess.pegs.join
    secret_code.casecmp(guess) == 0
  end

  def insert_lines
    puts "-----------------------------"
  end

  def turn
    Code.display_colors
    guess_code = get_guess
    insert_lines
    display_matches(guess_code)
    @turns += 1
  end

  def play
    while @turns < 10 || won?
      turn
      if won?
        puts "Winner!"
        break
      end
      puts "Turns left: #{10-@turns}"
      insert_lines
    end
    puts "Secret code was #{@secret_code.pegs.join}"
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
