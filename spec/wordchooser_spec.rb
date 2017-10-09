require './app/models/wordchooser'

describe WordChooser do
  let(:array) { ["yielding"] }
  let(:word) { WordChooser.new(array) }

  describe ':secret_word' do
    it "returns a secret word" do
      expect(word.secret_word).to eq("yielding")
    end
  end

  describe ':secret_letters' do
    it "returns an array of the secret word's letters" do
      expect(word.secret_letters).to eq(["Y", "I", "E", "L", "D", "I", "N", "G"])
    end
  end

  describe '#inspect' do
    it "returns the secret word" do
      expect(word.inspect).to eq("yielding")
    end
  end
end