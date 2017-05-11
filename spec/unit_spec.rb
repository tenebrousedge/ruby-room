require("spec_helper")

describe("Message") do

  describe(".create") do
    it("will check that the relationship has been created between users and messages.") do
      new_user = User.create({:name => 'test_user', :password => 'password'})
      new_message = Message.create(content: 'I am the very model of the modern Major General', user_id: new_user.id)
      expect(new_user.messages).to(eq([new_message]))
    end
  end

  describe(".destroy") do
    it("will check that the relationship has been deleted between users and messages.") do
      new_user = User.find_or_create_by({:name => 'test_user', :password => 'password'})
      new_message = Message.create(content: 'I am the very model of the modern Major General', user_id: new_user.id)
      expect(new_user.messages).to(eq([new_message]))
      new_user.destroy
      expect(new_user.messages).to(eq([]))
      expect(Message.all).to(eq([]))
    end
  end



end
