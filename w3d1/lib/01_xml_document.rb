class XmlDocument

  def initialize(indent=false)
    @indent = indent
    @indent_level = 0
  end

  def method_missing(method_name,*args,&block)
    attributes = args[0] || {}
    s = ""
    s += ("  " * @indent_level) if @indent
    s += "<#{method_name}"
    attributes.each do |key,val|
      s += " #{key}=\"#{val}\""
    end

    if block
      s += ">"
      s += "\n" if @indent
      @indent_level += 1
      s += block.call
      @indent_level -= 1
      s += ("  " * @indent_level) if @indent
      s += "</#{method_name}>"
      s += "\n" if @indent
    else
      s += "/>"
      s += "\n" if @indent
    end
    s
  end

end
