class Exile < ActiveRecord::Base
  validates :username, presence: true
  validates :address, presence: true
end
