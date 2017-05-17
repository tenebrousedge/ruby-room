module CreateData
  
  def self.create_user
    user = User.create(username: "eric", password_digest: "clapton", activity: false)
  end

end