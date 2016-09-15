def add(x,y)
  x + y
end

def subtract(x,y)
  x - y
end

def sum(array)
  array.reduce(0) { |sum, num| sum + num }
end

def multiply(*nums)
  nums.reduce(1) { |sum, num| sum * num }
end

def power(x,y)
  x ** y
end

def factorial(n)
  return n unless n > 2
  n * factorial(n-1)
end
