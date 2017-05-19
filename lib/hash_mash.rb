class HashMash
  def self.mash_the_hash(last_message_id)
    Message.all
      .select { |e| e > last_message_id.to_i }
      .map { |e| 
        { id: e.id,
          content: e.content,
          display_time: e.display_time,
          profile_picture: e.user.profile_picture
          about_me: e.user.about_me }}
  end

  def self.active_users
    User.all.select { |e| e.activity }.sort_by &:username
  end
end
