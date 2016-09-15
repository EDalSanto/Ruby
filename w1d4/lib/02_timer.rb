class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def padded(*nums)
    pad = ""
    nums.each_with_index do |num,index|
      pad += "%02d" % num
      pad += ":" if index != nums.length-1
    end
    pad
  end

  def time_string
    seconds = @seconds % 60
    @minutes = @seconds / 60
    minutes = @minutes % 60
    @hours = @minutes / 60
    hours = @hours % 60
    padded(hours,minutes,seconds)
  end

end
