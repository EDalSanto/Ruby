# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  num = rand(1..100)
  found = false
  guesses = 0
  while found == false
    puts "Guess a number!"
    input = gets.chomp.to_i
    if input > num
      puts "Your guess, #{input} is too high!"
    elsif input < num
      puts "Your guess, #{input} is too low!"
    else
      found = true
    end
    guesses += 1
  end
  puts "Nice, the number was #{num} and it took you #{guesses} guesses!"
end

if __FILE__ == $PROGRAM_NAME
  puts "Please provide a filename!"
  file1 = gets.chomp
  file2 = File.open("shuffle", 'w')
  File.open(file1).each do |line|
    shuffled = line.chars.shuffle.join
    file2.write(shuffled)
  end
  file2.close
end 
