class User < ActiveRecord::Base
  has_many :events
  validates :email, :name, presence: true
  validates :email, uniqueness: {case_sensitive: false}

  has_secure_password
end
