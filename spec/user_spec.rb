require("spec_helper")

describe 'User' do
  describe '#downcase_name' do
    it 'will downcase username before saving to the database' do
       user = User.create(username: "Tanner", password_digest: "test")
       expect(User.all[0].username).to eq 'tanner'
    end
  end
end
