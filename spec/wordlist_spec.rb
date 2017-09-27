require './app/models/wordlist'

describe WordList do
  describe "to_edited_a" do
    it "returns an edited array" do
      file = double
      expect(file).to receive(:readlines).
        and_return(["Yiddish\r\n","yield\r\n", "yielding\r\n"])
      
      wordlist = WordList.new(file.readlines)
      expect(wordlist.to_edited_a).to eq(["yield", "yielding"])
    end
  end
end