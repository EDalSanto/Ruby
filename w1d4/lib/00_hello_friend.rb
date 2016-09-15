class Friend
  def greeting(who=nil)
    return "Hello!" if who.nil?
    return "Hello, #{who}!"
  end
end
