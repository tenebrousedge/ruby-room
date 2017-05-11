class User < ActiveRecord::Base
  validates :name, presence: true, length: { in: 3..15 }, :uniqueness => true

  has_many :messages, dependent: :destroy

  before_save(:downcase_name)

private

  def downcase_name
    self.name = name.downcase
  end
end
