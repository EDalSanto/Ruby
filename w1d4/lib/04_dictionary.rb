class Dictionary
  attr_accessor :entries

  def initialize
    @entries = {}
  end

  def add(entry)
    @entries.merge!(entry) if entry.is_a? Hash
    @entries[entry] = nil if entry.is_a? String
  end

  def keywords
    @entries.keys.sort
  end

  def include?(key)
    keywords.include? key
  end

  def find(prefix)
    found = {}
    found_keys = keywords.select { |word| word.match(/^#{prefix}/) }
    found_keys.each { |word| found[word] = @entries[word] }
    found
  end

  def printable
    res = []
    @entries.sort.each do |key,val|
      res << "[#{key}] \"#{val}\""
    end
    res.join("\n")
  end

end

@d = Dictionary.new
@d.add("fish" => "aquatic animal")
@d.find("fish")
