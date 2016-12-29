class WordList
  attr_accessor :list

  def initialize(filename)
    @list = create_list(filename)
    edit_list
  end

  def print
    @list.join(", ")
  end

private

  def create_list(filename)
    words = File.new(filename)
    words.readlines
  end

  def edit_list
    trim_words
    delete_words
    @list
  end

  def trim_words
    @list.each { |word| word.gsub!(/\r\n/, "") }
  end

  def delete_words
    @list.delete_if do |word|
      !word.length.between?(5, 12) || /[A-Z]/.match(word)
    end
  end

end
