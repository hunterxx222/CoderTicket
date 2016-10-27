class User < ActiveRecord::Base
  validates :email, :name, presence: true
  validates :email, uniqueness: {case_sensitive: false}

  has_secure_password
end
