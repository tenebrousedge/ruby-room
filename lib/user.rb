class User < ActiveRecord::Base
  validates :username, presence: true, length: { in: 3..15 }, :uniqueness => true

  has_secure_password

  has_many :messages, dependent: :destroy

  before_save(:downcase_name)

private

  def downcase_name
    self.username = username.downcase
  end
end
