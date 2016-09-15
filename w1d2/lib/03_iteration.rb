# ### Factors
#
# Write a method `factors(num)` that returns an Array containing all the
# factors of a given number.

def factors(num)
  (1..num).select { |int| num % int == 0 }
end

# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the Array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator

class Array
  def bubble_sort!(&prc)
    loop do
      swaps = false
      self.each_index do |idx|
        if idx < self.length - 1
          if block_given?
            if prc.call(self[idx],self[idx+1]) == 1
              self[idx],self[idx+1]=self[idx+1],self[idx]
              swaps = true
            end
          else
            if self[idx] > self[idx+1]
              self[idx],self[idx+1]=self[idx+1],self[idx]
              swaps = true
            end
          end
        end
      end
      break if swaps == false
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end

end

# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# Array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an Array of
# words).

def substrings(string)
  # All substrings will be n!
  # For each character, add from that character until the end of the string in as many slices as the length of given char till the end
  substrings = []
  # Iterate through each char in string by index
  string.chars.each_index do |current|
    # Iterate through range from current index of char in string till final string index, string.length-1
    (current..string.length-1).each do |idx|
      # Each substring is the current char up to how far along we are in the range till the end of the string from current
      substring = string[current..idx]
      substrings << substring
    end
  end
  substrings
end

def subwords(word, dictionary)
  potentials = substrings(word)
  potentials.select { |substring| dictionary.include?(substring) }.uniq
end

# ### Doubler
# Write a `doubler` method that takes an Array of integers and returns an
# Array with the original elements multiplied by two.

def doubler(array)
  array.map { |num| num * 2 }
end

# ### My Each
# Extend the Array class to include a method named `my_each` that takes a
# block, calls the block on every element of the Array, and then returns
# the original Array. Do not use Enumerable's `each` method. I want to be
# able to write:
#
# ```ruby
# # calls my_each twice on the Array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3
#
# p return_value # => [1, 2, 3]
# ```

class Array
  def my_each(&prc)
    self.length.times { |idx| prc.call(self[idx]) }
    self
  end
end

# ### My Enumerable Methods
# * Implement new `Array` methods `my_map` and `my_select`. Do
#   it by monkey-patching the `Array` class. Don't use any of the
#   original versions when writing these. Use your `my_each` method to
#   define the others. Remember that `each`/`map`/`select` do not modify
#   the original Array.
# * Implement a `my_inject` method. Your version shouldn't take an
#   optional starting argument; just use the first element. Ruby's
#   `inject` is fancy (you can write `[1, 2, 3].inject(:+)` to shorten
#   up `[1, 2, 3].inject { |sum, num| sum + num }`), but do the block
#   (and not the symbol) version. Again, use your `my_each` to define
#   `my_inject`. Again, do not modify the original Array.

class Array
  def my_map(&prc)
    new_arr = []
    self.my_each do |el|
      new_arr << prc.call(el)
    end
    new_arr
  end

  def my_select(&prc)
    new_arr = []
    self.my_each do |el|
      new_arr << el if prc.call(el) == true
    end
    new_arr
  end

  def my_inject(&blk)
    accumulator = self.shift
    self.my_each do |el|
      accumulator = blk.call(accumulator,el)
    end
    accumulator
  end
end

# ### Concatenate
# Create a method that takes in an `Array` of `String`s and uses `inject`
# to return the concatenation of the strings.
#
# ```ruby
# concatenate(["Yay ", "for ", "strings!"])
# # => "Yay for strings!"
# ```

def concatenate(strings)
  strings.inject { |memo, string| memo + string }
end
