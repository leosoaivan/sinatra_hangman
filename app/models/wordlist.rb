class WordList
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def to_edited_a
    stripped_array.delete_if do |word|
      !word.length.between?(5, 12) || /[A-Z]/.match(word)
    end
  end

  private

    def stripped_array
      file.map! { |word| word.strip }
    end

end
