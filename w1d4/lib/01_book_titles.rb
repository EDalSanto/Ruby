class Book
  attr_reader :title

  def title=(new_title)
    word_arr = new_title.split
    never_unless_first = %w{the a an and in of}
    word_arr.map!.each_with_index do |word,index|
      if index == 0 || word == "I" || !never_unless_first.include?(word)
        word.capitalize
      # Else just return the word
      else
        word
      end
    end
    @title = word_arr.join(' ')
  end

end
