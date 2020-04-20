class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  has_secure_token :api_key
  has_secure_password

  validates_presence_of :password_digest

end
