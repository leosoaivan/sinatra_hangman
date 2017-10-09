require './app/helpers/helper'

xdescribe HelperUtils do
  let(:subject) { Class.new { include HelperUtils } }
  let(:session) { last_request.env["rack.session"] }

  describe '#check_response()' do
    # scenario "if the letter has been used already" do
      it "returns a message" do
        session[:used_letters] = ["A"]
        subject.new.check_response("A")
        expect(session[:message]).to eq("Hello")
      end
    # end
  end
end