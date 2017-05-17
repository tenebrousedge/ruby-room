require("spec_helper")

describe("HashMash") do
  describe(".mash_the_hash") do
    it("adds username to the message hashes") do
      message = Message.create(content: "this is some content", user_id: nil)
      user = User.create(username: "tanner", password_digest: "test")
      user.messages << message
      new_hash = HashMash.mash_the_hash
      expect(new_hash[0][:username]).to eq "tanner"
    end
  end

  describe '.active_users' do
    it 'returns all actve users' do
      message = Message.create(content: "this is some content", user_id: nil)
      user = User.create(username: "tanner", password_digest: "test", activity: true)
      user.messages << message
      expect(HashMash.active_users[0].username).to eq("tanner")
    end
  end
end
