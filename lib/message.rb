class Message < ActiveRecord::Base

  validates :content, presence: true
  belongs_to :user
  before_save :escape_chars

private

  def escape_chars
    self.content = self.content.gsub(/[<>\/]/, '<' => '&#60', '>' => '&#62', '/' => '&#47')
  end

end
