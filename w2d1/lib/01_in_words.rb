require 'pry'

ONES = {
 0 => "zero",
 1 => "one",
 2 => "two",
 3 => "three",
 4 => "four",
 5 => "five",
 6 => "six",
 7 => "seven",
 8 => "eight",
 9 => "nine"
}

TENS = {
 20 => "twenty",
 30 => "thirty",
 40 => "forty",
 50 => "fifty",
 60 => "sixty",
 70 => "seventy",
 80 => "eighty",
 90 => "ninety"
}

TEENS = {
 10 => "ten",
 11 => "eleven",
 12 => "twelve",
 13 => "thirteen",
 14 => "fourteen",
 15 => "fifteen",
 16 => "sixteen",
 17 => "seventeen",
 18 => "eighteen",
 19 => "nineteen"
}

MAGNITUDES = {
 100 => "hundred",
 1000 => "thousand",
 1_000_000 => "million",
 1_000_000_000 => "billion",
 1_000_000_000_000 => "trillion"
}

class Fixnum

  def in_words
    if self < 10
      ONES[self]
    elsif self < 20
      TEENS[self]
    elsif self < 100
      if self % 10 == 0
        TENS[self]
      else
        tens,ones = self.divmod(10)
        tens *= 10
        TENS[tens] + " " + ONES[ones]
      end
    # Find magnitude, quotient and remainder, and then call in_words on q and r
    else
      mag = self.find_magnitude
      q,r = self.divmod(mag)
      if r == 0
        ONES[q] + " " + MAGNITUDES[mag]
      else
        q.in_words + " " + MAGNITUDES[mag] + " " + r.in_words
      end
    end
  end

  def find_magnitude
    # Finds biggest magnitude less than or equal to self and then returns it
    MAGNITUDES.keys.take_while { |m| m <= self }.last
  end

end
