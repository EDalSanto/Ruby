def echo(word)
  word
end

def shout(word)
  word.upcase
end

def repeat(word, repeats=2)
  return word unless repeats > 1
  word + ' ' + repeat(word,repeats-1)
end

def start_of_word(word,slice)
  word[0...slice]
end

def first_word(string)
  string.split(/\s/).first
end

def titleize(string)
  little_words = ['and','the','over']
  word_arr = string.split
  titleized = word_arr.map.with_index do |word, index|
    unless index != 0 && little_words.include?(word)
      word.capitalize
    else
      word
    end
  end
  titleized.join(' ')
end
