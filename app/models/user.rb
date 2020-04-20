class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true

  validates_presence_of :password_digest, :api_key

  has_secure_password
  has_secure_token :api_key
end
