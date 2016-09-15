class RPNCalculator
  attr_accessor :value

  def initialize
    @stack = []
    @value = 0
    @operators = {
      :* => "times",
      :+ => "plus",
      :- => "minus",
      :/ => "divide"
    }
  end

  def push(num)
    @stack << num
  end

  def raise_empty
    raise Exception.new("calculator is empty")
  end

  def pop_two
    operand1 = @stack.pop
    operand2 = @stack.pop
    raise_empty if operand1.nil? || operand2.nil?
    [operand1, operand2]
  end

  def plus
    operand1, operand2 = pop_two
    @value = operand1 + operand2
    @stack << @value
  end

  def minus
    operand1, operand2 = pop_two
    @value = operand2 - operand1
    @stack << @value
  end

  def divide
    operand1, operand2 = pop_two
    @value = operand2.to_f / operand1
    @stack << @value
  end

  def times
    operand1, operand2 = pop_two
    @value = operand2.to_f * operand1
    @stack << @value
  end

  def tokens(string)
    # Convert to int if el is a string int, else symbol
    string.split.map! { |el| el =~ /\d/ ? el.to_i : el.to_sym }
  end

  def evaluate(string)
    t = tokens(string)
    t.each do |token|
      if token.is_a? Fixnum
        @stack << token
      else # Must be a symbol
        # Send calculator "message" of method from mapping above
        send(@operators[token])
      end
    end
    @value
  end

end

if __FILE__ == $PROGRAM_NAME
  calc = RPNCalculator.new
  if ARGV.empty?
    input = nil
    while input != "\n"
      puts "Please enter an operand or operator!"
      input = gets.chomp
      calc.evaluate(input)
    end
    p calc.value
  else
    f = File.open(ARGV.first)
    f.each do |line|
      puts calc.evaluate(line)
    end
    f.close
  end
end
