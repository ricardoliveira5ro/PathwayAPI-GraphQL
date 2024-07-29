class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@[^@\s]+\z/

  has_secure_password
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: EMAIL_REGEXP

  normalizes :email, with: -> { _1.strip.downcase }
end
