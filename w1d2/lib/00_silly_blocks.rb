def reverser(&prc)
  prc.call.split(/\s/).map { |word| word.reverse }.join(' ')
end

def adder(default=1,&prc)
  prc.call + default
end

def repeater(repeats=1,&block)
  repeats.times { block.call }
end
