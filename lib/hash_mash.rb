class HashMash
  def self.mash_the_hash(last_message_id)
    mashed_hash_a = []
    Message.all.each do |message|
      user = User.find(message.user_id)
      if  message.id > last_message_id.to_i
        mashed_hash_a.push({
          :id => message.id,
          :content => message.content,
          :display_time => message.display_time,
          :username => user.username,
          :profile_picture => user.profile_picture,
          :about_me => user.about_me
        })
      end
    end
    mashed_hash_a
  end

  def self.active_users
    active_users = []
    User.all.each do |user|
      if user.activity == true
        active_users.push(user)
      end
    end
    active_users
  end
end
