class User < ActiveRecord::Base
  validates :username, presence: true, length: { in: 3..15 }, :uniqueness => true

  has_secure_password

  has_many :messages, dependent: :destroy
  before_save(:downcase_name)
  before_update(:escape_chars)

private

  def downcase_name
    self.username = username.downcase
  end

  def escape_chars
    if self.about_me != nil
      self.about_me = self.about_me.gsub(/[<>\/\"\']/, '<' => '&#60', '>' => '&#62', '/' => '&#47', '"' => '&quot', "'" => "&#39")
    end
  end
end
