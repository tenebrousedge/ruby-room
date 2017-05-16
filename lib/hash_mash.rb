module HashMash
  def self.mash_the_hash
    mashed_hash_a = []
    Message.all.each do |message|
      user = User.find(message.user_id)
      mashed_hash_a.push({
        :content => message.content,
        :created_at => message.created_at,
        :username => user.username
        })
    end
    mashed_hash_a
  end
end
