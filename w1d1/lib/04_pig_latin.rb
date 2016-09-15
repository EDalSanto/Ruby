def translate_word(word)
  if word[0] =~ /[aeiou]/i
    word = word + "ay"
  else # Word starts with at least one consonant
    # Match the first "string" of consonants
    first_consonants = word.match(/[^aeio]+/i)[0]
    letters_to_swap = first_consonants.length
    # Check if beginning of word is capitalized
    if first_consonants[0].match(/\p{Lu}/)
      first_consonants.downcase!
      word = word[letters_to_swap..-1].capitalize + first_consonants + "ay"
    else
      word = word[letters_to_swap..-1] + first_consonants + "ay"
    end
  end
end

def translate(string)
  word_arr = string.split
  word_arr.map! { |word| translate_word(word) }
  word_arr.join(' ')
end
