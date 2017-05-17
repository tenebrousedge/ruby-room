require("spec_helper")

describe "Message" do
  describe '#escape_chars' do
    it 'tests message content for certain chars and replaces them with escaped chars' do
      message = Message.create(content: "<script>world</script>", user_id: nil)
      user = User.create(username: "B.B. King", password_digest: "Lucille")
      user.messages << message
      expect(Message.all[0].content).to eq "&#60script&#62world&#60&#47script&#62"
    end
  end  
end
