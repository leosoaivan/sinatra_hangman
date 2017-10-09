class TextParser
  attr_reader :parsed

  def initialize(file)
    @parsed = parser(File.new(file).readlines)
  end

  protected

  def parser(file)
    arrayer(file).delete_if do |word|
      !word.length.between?(5, 12) || /[A-Z]/.match(word)
    end
  end

  def arrayer(file)
    file.map! { |word| word.strip }
  end
end
