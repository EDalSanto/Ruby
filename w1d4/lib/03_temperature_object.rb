class Temperature
  attr_reader :celsius, :fahrenheit

  def initialize(entry={})
    @fahrenheit = entry[:f]
    @celsius = entry[:c]
  end

  def in_fahrenheit
    @fahrenheit == nil ? Temperature.ctof(@celsius) : @fahrenheit
  end

  def in_celsius
    @celsius == nil ? Temperature.ftoc(@fahrenheit) : @celsius
  end

  def self.from_celsius(temp)
    Temperature.new(:c => temp)
  end

  def self.from_fahrenheit(temp)
    Temperature.new(:f => temp)
  end

  def self.ftoc(temp)
    (temp - 32) * (5.0 / 9.0)
  end

  def self.ctof(temp)
    (temp * 9.0 / 5.0) + 32
  end

end

class Celsius < Temperature

  def initialize(celsius)
    @celsius = celsius
  end

end

class Fahrenheit < Temperature

  def initialize(fahrenheit)
    @fahrenheit = fahrenheit
  end

end
