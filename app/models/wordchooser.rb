class WordChooser
  attr_reader :secret_word, :secret_letters

  def initialize(array)
    @secret_word = array.sample
    @secret_letters = secret_word.upcase.split("")
  end

  def inspect
    "#{secret_word}"
  end
end