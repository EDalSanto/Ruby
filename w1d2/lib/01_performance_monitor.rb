def measure(calls=1,&block)
  before = Time.now
  calls.times { block.call }
  after = Time.now
  # Return Average 
  (after - before)/calls
end
