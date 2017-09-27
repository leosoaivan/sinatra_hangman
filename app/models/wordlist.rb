class WordList
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def to_edited_a
    stripped_array.delete_if do |word|
      !word.length.between?(5, 12) || /[A-Z]/.match(word)
    end
  end

  private

    def stripped_array
      filename.map! { |word| word.strip }
    end

end
