require './app/models/textparser'

describe TextParser do
  describe '#initialize' do
    it "returns an array of words" do
      file = double
      expect(file).to receive(:readlines).
        and_return(["Yiddish\r\n", "yield\r\n", "yielding\r\n"])
      textparser = TextParser.new(file)
      
      expect(textparser.parsed).to eq(["yield", "yielding"])
    end
  end
end